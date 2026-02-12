import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart'; // Required for SystemUiOverlayStyle

class AdaptiveSliverHeader extends StatefulWidget {
  final Widget expandedContent;
  final Widget collapsedContent;
  final Widget background;
  final Widget body;
  final double expandedHeight;
  final double maxRadius;
  final Widget? bottomSheet;
  final bool isVideoMode;
  final bool isFullScreen;
  final Widget? videoPlayer;

  const AdaptiveSliverHeader({
    super.key,
    required this.expandedContent,
    required this.collapsedContent,
    required this.background,
    required this.body,
    required this.expandedHeight,
    this.maxRadius = 24,
    this.bottomSheet,
    this.isVideoMode = false,
    this.isFullScreen = false,
    this.videoPlayer,
  });

  @override
  State<AdaptiveSliverHeader> createState() => _AdaptiveSliverHeaderState();
}

class _AdaptiveSliverHeaderState extends State<AdaptiveSliverHeader> {
  final GlobalKey _barKey = GlobalKey();
  final GlobalKey _sheetKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  double _collapsedHeight = 0;
  double _sheetHeight = 0;
  double _rawBarHeight = 0;

  bool _timerTriggered = false;
  bool _userHasScrolled = false;
  bool _hasHiddenOnce = false;

  Timer? _appearanceTimer;
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _handleMeasurements();
    _startTimer();

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        final double currentOffset = _scrollController.offset;
        setState(() {
          _scrollPosition = currentOffset;
          if (_scrollPosition > 0 && !_userHasScrolled) {
            _userHasScrolled = true;
            _appearanceTimer?.cancel();
          }
          if (currentOffset >= (widget.expandedHeight - _collapsedHeight)) {
            _hasHiddenOnce = true;
          }
        });
      }
    });
  }

  void _handleMeasurements() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? barBox = _barKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? sheetBox = _sheetKey.currentContext?.findRenderObject() as RenderBox?;

      if (mounted) {
        setState(() {
          if (barBox != null) {
            final double statusBar = MediaQuery.of(context).padding.top;
            _rawBarHeight = barBox.size.height;
            _collapsedHeight = statusBar + _rawBarHeight + (_rawBarHeight / 2);
          }
          if (sheetBox != null) {
            _sheetHeight = sheetBox.size.height + MediaQuery.of(context).padding.bottom;
          }
        });
      }
    });
  }

  void _startTimer() {
    if (widget.bottomSheet != null) {
      _appearanceTimer = Timer(const Duration(seconds: 1), () {
        if (mounted && _scrollPosition <= 0 && !_userHasScrolled) {
          setState(() => _timerTriggered = true);
        }
      });
    }
  }

  @override
  void dispose() {
    _appearanceTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color surfaceColor = Theme.of(context).colorScheme.surface;

    if (_collapsedHeight == 0 || (widget.bottomSheet != null && _sheetHeight == 0)) {
      return Scaffold(
        body: Opacity(
          opacity: 0,
          child: Column(
            children: [
              Container(key: _barKey, child: widget.collapsedContent),
              if (widget.bottomSheet != null) Container(key: _sheetKey, child: widget.bottomSheet),
            ],
          ),
        ),
      );
    }

    double scrollRange = widget.expandedHeight - _collapsedHeight;
    double progress = widget.isVideoMode ? 0.0 : (_scrollPosition / scrollRange).clamp(0.0, 1.0);

    double delayedProgress = widget.isVideoMode ? 0.0 : ((progress - 0.3) / 0.7).clamp(0.0, 1.0);
    double sheetOffset = delayedProgress * _sheetHeight;
    double sheetOpacity = widget.isVideoMode ? 1.0 : (1.0 - (delayedProgress * 2.0)).clamp(0.0, 1.0);

    bool showViaTimer = _timerTriggered && !_userHasScrolled;
    bool showViaScroll = (_timerTriggered || _hasHiddenOnce) && progress < 1.0;
    bool isSheetVisible = widget.isVideoMode || (showViaTimer || showViaScroll);

    Color navBarColor = isDarkMode ? (isSheetVisible ? const Color(0xFF2B2B2B) : surfaceColor) : surfaceColor;

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double videoHeight = (MediaQuery.of(context).size.width * 9 / 16) + statusBarHeight;
    final double currentExpandedHeight = widget.isFullScreen
        ? MediaQuery.of(context).size.height
        : (widget.isVideoMode ? videoHeight : widget.expandedHeight);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarContrastEnforced: false,
        statusBarColor: Colors.transparent,
      ),
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: surfaceColor,
              body: Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _AdaptiveHeaderDelegate(
                          expandedHeight: currentExpandedHeight,
                          collapsedHeight: (widget.isVideoMode || widget.isFullScreen) ? currentExpandedHeight : _collapsedHeight,
                          statusBarHeight: statusBarHeight,
                          barHeight: _rawBarHeight,
                          background: widget.background,
                          expandedUI: widget.expandedContent,
                          collapsedUI: widget.collapsedContent,
                          maxRadius: widget.maxRadius,
                          isVideoMode: widget.isVideoMode || widget.isFullScreen,
                          videoPlayer: widget.videoPlayer,
                        ),
                      ),
                      if (!widget.isFullScreen) widget.body,
                    ],
                  ),
                  if (widget.bottomSheet != null)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOutQuart,
                        transform: Matrix4.translationValues(0, !isSheetVisible ? _sheetHeight : sheetOffset, 0),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: sheetOpacity,
                          child: Padding(padding: const EdgeInsets.only(left: 0, right: 0), child: widget.bottomSheet!),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          AnimatedContainer(duration: const Duration(milliseconds: 350), height: MediaQuery.of(context).padding.bottom, color: navBarColor),
        ],
      ),
    );
  }
}

class _AdaptiveHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapsedHeight;
  final double statusBarHeight;
  final double barHeight;
  final Widget background;
  final Widget expandedUI;
  final Widget collapsedUI;
  final double maxRadius;
  final bool isVideoMode;
  final Widget? videoPlayer;

  _AdaptiveHeaderDelegate({
    required this.expandedHeight,
    required this.collapsedHeight,
    required this.statusBarHeight,
    required this.barHeight,
    required this.background,
    required this.expandedUI,
    required this.collapsedUI,
    required this.maxRadius,
    this.isVideoMode = false,
    this.videoPlayer,
  });

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => OverScrollHeaderStretchConfiguration();

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double stretchFactor = shrinkOffset < 0 ? (1 + shrinkOffset.abs() / expandedHeight) : 1.0;
    final double progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final double radius = shrinkOffset < 0 ? 0 : lerpDouble(0, maxRadius, progress)!;

    final double expandedOpacity = isVideoMode ? 0.0 : (1.0 - (progress * 2.5)).clamp(0.0, 1.0);
    final double collapsedOpacity = isVideoMode ? 0.0 : ((progress - 0.6) / 0.4).clamp(0.0, 1.0);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Stack(
        key: ValueKey(isVideoMode),
        clipBehavior: Clip.none,
        children: [
          if (!isVideoMode) ...[
            Positioned.fill(
              child: Transform.scale(
                scale: stretchFactor,
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
                  child: background,
                ),
              ),
            ),
            Positioned.fill(
              child: Transform.scale(
                scale: stretchFactor,
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: progress * 15, sigmaY: progress * 15),
                    child: Container(color: Colors.black.withAlpha((52 * progress).toInt())),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(0, shrinkOffset < 0 ? shrinkOffset.abs() : 0),
                child: expandedOpacity > 0 ? Opacity(opacity: expandedOpacity, child: expandedUI) : const SizedBox.shrink(),
              ),
            ),
            if (progress > 0.5) _buildCollapsedBar(progress, collapsedOpacity),
          ] else if (videoPlayer != null) ...[
            Positioned.fill(
              child: Container(color: Colors.black),
            ),
            Positioned.fill(
              child: SafeArea(
                bottom: false,
                child: videoPlayer!,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildCollapsedBar(double progress, double opacity) {
    final double internalProgress = ((progress - 0.5) / 0.5).clamp(0.0, 1.0);
    final double smoothProgress = Curves.easeOutCubic.transform(internalProgress);
    final double slideDistance = barHeight;

    return Positioned(
      top: 0,
      left: barHeight / 4,
      right: barHeight / 4,
      child: Opacity(
        opacity: opacity,
        child: Transform.translate(
          offset: Offset(0, (statusBarHeight + (barHeight / 4)) - (slideDistance * (1 - smoothProgress))),
          child: collapsedUI,
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => collapsedHeight;

  @override
  bool shouldRebuild(covariant _AdaptiveHeaderDelegate oldDelegate) => true;
}
