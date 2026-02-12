import 'package:flutter/material.dart';
import 'package:gtr/core/video/components/video_controls.dart';
import 'package:video_player/video_player.dart';
import '../../../core/models/video_model.dart';
import '../logic/video_player_logic.dart';

class CustomVideoPlayer extends StatefulWidget {
  final VideoPlayerLogic? logic;
  final List<VideoModel>? playlist;
  final String initialQuality;

  const CustomVideoPlayer({super.key, this.logic, this.playlist, this.initialQuality = "1080p"});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> with TickerProviderStateMixin {
  VideoPlayerLogic? _internalLogic;
  late VideoPlayerLogic _effectiveLogic;

  @override
  void initState() {
    super.initState();
    _initLogic();
  }

  void _initLogic() {
    if (widget.logic != null) {
      _effectiveLogic = widget.logic!;
    } else if (widget.playlist != null) {
      _internalLogic = VideoPlayerLogic(playlist: widget.playlist!, vsync: this, initialQuality: widget.initialQuality);
      _effectiveLogic = _internalLogic!;
    }
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.logic != oldWidget.logic || widget.playlist != oldWidget.playlist) {
      _internalLogic?.dispose();
      _internalLogic = null;
      _initLogic();
    }
  }

  @override
  void dispose() {
    _internalLogic?.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    double newOffset = _effectiveLogic.dragOffset + details.delta.dy;
    if (!_effectiveLogic.isFullScreen) {
      _effectiveLogic.dragOffset = newOffset.clamp(-120.0, 0.0);
    } else {
      _effectiveLogic.dragOffset = newOffset.clamp(0.0, 120.0);
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    double velocity = details.primaryVelocity ?? 0;
    if (_effectiveLogic.dragOffset.abs() > 80.0 || velocity.abs() > 400) {
      _effectiveLogic.toggleFullScreen();
    } else {
      _effectiveLogic.dragOffset = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _effectiveLogic,
      builder: (context, _) {
        return PopScope(
          canPop: !_effectiveLogic.isFullScreen,
          onPopInvoked: (didPop) {
            if (_effectiveLogic.isFullScreen) _effectiveLogic.toggleFullScreen();
          },
          child: OrientationBuilder(
            builder: (context, orientation) {
              final double height = orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height / 3
                  : MediaQuery.of(context).size.height;

              return Center(
                child: Container(
                  width: double.infinity,
                  height: height,
                  color: Colors.black,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: _effectiveLogic.controller?.value.aspectRatio ?? 16 / 9,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _effectiveLogic.toggleOverlay,
                        onVerticalDragUpdate: _onVerticalDragUpdate,
                        onVerticalDragEnd: _onVerticalDragEnd,
                        child: AnimatedContainer(
                          duration: _effectiveLogic.dragOffset == 0 ? const Duration(milliseconds: 400) : Duration.zero,
                          curve: Curves.easeOutCubic,
                          transform: Matrix4.translationValues(0, _effectiveLogic.dragOffset, 0),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (_effectiveLogic.controller != null && _effectiveLogic.isInitialized)
                                VideoPlayer(_effectiveLogic.controller!),

                              if (!_effectiveLogic.isInitialized) const Center(child: CircularProgressIndicator(color: Colors.red)),

                              if (_effectiveLogic.isInitialized &&
                                  _effectiveLogic.captionsEnabled &&
                                  _effectiveLogic.controller != null &&
                                  _effectiveLogic.controller!.value.caption.text.isNotEmpty)
                                Positioned(
                                  bottom: _effectiveLogic.showControls ? 50 : 20,
                                  left: 20,
                                  right: 20,
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: _effectiveLogic.captionBgColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        _effectiveLogic.controller!.value.caption.text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: _effectiveLogic.captionFontSize,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              VideoControls(logic: _effectiveLogic),

                              if (!_effectiveLogic.showControls && !_effectiveLogic.isDragging)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: SizedBox(
                                    height: 3,
                                    child: _effectiveLogic.controller != null && _effectiveLogic.isInitialized
                                        ? VideoProgressIndicator(
                                            _effectiveLogic.controller!,
                                            allowScrubbing: false,
                                            colors: const VideoProgressColors(
                                              playedColor: Colors.red,
                                              bufferedColor: Colors.white24,
                                              backgroundColor: Colors.white10,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
