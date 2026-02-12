import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchSheetGrid extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final ScrollPhysics? physics;

  /// Set this to [true] if the grid is inside a ScrollView or Column.
  final bool shrinkWrap;

  /// Callback for pagination/infinite scroll logic.
  final VoidCallback? onLimitReached;
  final ScrollController? controller;

  const SearchSheetGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisSpacing = 12,
    this.mainAxisSpacing = 12,
    this.physics,
    this.shrinkWrap = false,
    this.onLimitReached,
    this.controller,
  });

  @override
  State<SearchSheetGrid> createState() => _SearchSheetGridState();
}

class _SearchSheetGridState extends State<SearchSheetGrid> {
  ScrollController? _internalController;

  // Getter to determine which controller to use
  ScrollController? get _effectiveController =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();

    // Only initialize a controller and listener if we aren't shrinkWrapping.
    // ShrinkWrapped grids are controlled by their parent's scroll view.
    if (!widget.shrinkWrap) {
      if (widget.controller == null) {
        _internalController = ScrollController();
      }
      _effectiveController?.addListener(_scrollListener);
    }
  }

  void _scrollListener() {
    if (_effectiveController == null || !_effectiveController!.hasClients) return;

    final maxScroll = _effectiveController!.position.maxScrollExtent;
    final currentScroll = _effectiveController!.position.pixels;

    // Trigger limit reached when 80% scrolled
    if (currentScroll >= (maxScroll * 0.8)) {
      widget.onLimitReached?.call();
    }
  }

  @override
  void dispose() {
    _internalController?.removeListener(_scrollListener);
    _internalController?.dispose();
    super.dispose();
  }

  int _getCrossAxisCount(double width) {
    if (width < 350) return 2;
    if (width < 600) return 3;
    if (width < 900) return 4;
    return 5;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);

        return MasonryGridView.builder(
          controller: widget.shrinkWrap ? null : _effectiveController,
          itemCount: widget.itemCount,
          physics: widget.physics,
          shrinkWrap: widget.shrinkWrap,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          mainAxisSpacing: widget.mainAxisSpacing,
          crossAxisSpacing: widget.crossAxisSpacing,
          itemBuilder: widget.itemBuilder,
        );
      },
    );
  }
}