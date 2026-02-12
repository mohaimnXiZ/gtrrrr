import 'package:flutter/material.dart';

/// A widget that animates its child with a staggered delay based on its index.
/// Perfect for list items, grid items, or any collection of widgets that need
/// to appear with a cascading animation effect.
class StaggeredAnimation extends StatefulWidget {
  /// The child widget to animate
  final Widget child;

  /// The index of this item in the list (used to calculate delay)
  final int index;

  /// Base delay in milliseconds before animation starts (default: 0)
  final int initialDelay;

  /// Delay in milliseconds between each item (default: 100)
  final int itemDelay;

  /// Duration of the animation in milliseconds (default: 400)
  final int duration;

  /// Starting offset for slide animation (default: Offset(0, 0.1))
  final Offset slideOffset;

  /// Starting opacity (default: 0.0)
  final double initialOpacity;

  /// Animation curve (default: Curves.easeOutCubic)
  final Curve curve;

  /// Whether to animate on initialization (default: true)
  final bool animate;

  const StaggeredAnimation({
    super.key,
    required this.child,
    required this.index,
    this.initialDelay = 0,
    this.itemDelay = 100,
    this.duration = 400,
    this.slideOffset = const Offset(0, 0.1),
    this.initialOpacity = 0.0,
    this.curve = Curves.easeOutCubic,
    this.animate = true,
  });

  @override
  State<StaggeredAnimation> createState() => _StaggeredAnimationState();
}

class _StaggeredAnimationState extends State<StaggeredAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: widget.initialOpacity,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _slideAnimation = Tween<Offset>(
      begin: widget.slideOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    if (widget.animate) {
      _startAnimation();
    } else {
      _controller.value = 1.0;
    }
  }

  void _startAnimation() {
    final delay = widget.initialDelay + (widget.index * widget.itemDelay);
    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

/// A convenience widget that wraps a list of children with StaggeredAnimation
class StaggeredList extends StatelessWidget {
  /// List of children to animate
  final List<Widget> children;

  /// Base delay in milliseconds before animation starts (default: 0)
  final int initialDelay;

  /// Delay in milliseconds between each item (default: 100)
  final int itemDelay;

  /// Duration of the animation in milliseconds (default: 400)
  final int duration;

  /// Starting offset for slide animation (default: Offset(0, 0.1))
  final Offset slideOffset;

  /// Starting opacity (default: 0.0)
  final double initialOpacity;

  /// Animation curve (default: Curves.easeOutCubic)
  final Curve curve;

  /// Scroll direction (default: Axis.vertical)
  final Axis scrollDirection;

  /// Padding around the list
  final EdgeInsetsGeometry? padding;

  /// Whether to shrink wrap the list
  final bool shrinkWrap;

  /// Whether to disable scrolling
  final bool disableScroll;

  const StaggeredList({
    super.key,
    required this.children,
    this.initialDelay = 0,
    this.itemDelay = 100,
    this.duration = 400,
    this.slideOffset = const Offset(0, 0.1),
    this.initialOpacity = 0.0,
    this.curve = Curves.easeOutCubic,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.shrinkWrap = false,
    this.disableScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: disableScroll ? const NeverScrollableScrollPhysics() : null,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return StaggeredAnimation(
          index: index,
          initialDelay: initialDelay,
          itemDelay: itemDelay,
          duration: duration,
          slideOffset: slideOffset,
          initialOpacity: initialOpacity,
          curve: curve,
          child: children[index],
        );
      },
    );
  }
}

/// A convenience widget for staggered grid animations
class StaggeredGrid extends StatelessWidget {
  /// Number of items in the grid
  final int itemCount;

  /// Builder function for grid items
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// Number of columns (default: 2)
  final int crossAxisCount;

  /// Base delay in milliseconds before animation starts (default: 0)
  final int initialDelay;

  /// Delay in milliseconds between each item (default: 100)
  final int itemDelay;

  /// Duration of the animation in milliseconds (default: 400)
  final int duration;

  /// Starting offset for slide animation (default: Offset(0, 0.1))
  final Offset slideOffset;

  /// Starting opacity (default: 0.0)
  final double initialOpacity;

  /// Animation curve (default: Curves.easeOutCubic)
  final Curve curve;

  /// Main axis spacing
  final double mainAxisSpacing;

  /// Cross axis spacing
  final double crossAxisSpacing;

  /// Child aspect ratio
  final double childAspectRatio;

  /// Padding around the grid
  final EdgeInsetsGeometry? padding;

  /// Whether to shrink wrap the grid
  final bool shrinkWrap;

  /// Whether to disable scrolling
  final bool disableScroll;

  const StaggeredGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.initialDelay = 0,
    this.itemDelay = 100,
    this.duration = 400,
    this.slideOffset = const Offset(0, 0.1),
    this.initialOpacity = 0.0,
    this.curve = Curves.easeOutCubic,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
    this.padding,
    this.shrinkWrap = false,
    this.disableScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: disableScroll ? const NeverScrollableScrollPhysics() : null,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return StaggeredAnimation(
          index: index,
          initialDelay: initialDelay,
          itemDelay: itemDelay,
          duration: duration,
          slideOffset: slideOffset,
          initialOpacity: initialOpacity,
          curve: curve,
          child: itemBuilder(context, index),
        );
      },
    );
  }
}
