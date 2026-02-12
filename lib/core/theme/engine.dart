import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ThemeRevealWidget extends StatefulWidget {
  final Widget child;

  const ThemeRevealWidget({super.key, required this.child});

  static _ThemeRevealWidgetState? of(BuildContext context) => context.findAncestorStateOfType<_ThemeRevealWidgetState>();

  @override
  State<ThemeRevealWidget> createState() => _ThemeRevealWidgetState();
}

class _ThemeRevealWidgetState extends State<ThemeRevealWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  ui.Image? _screenshot;
  Offset _center = Offset.zero;
  final GlobalKey _repaintKey = GlobalKey();

  // Flag to handle rapid clicking during the 700ms window
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    // Reverted to 700ms for that majestic, high-end feel
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    // EaseInOutQuart is highly recommended for 700ms
    // as it creates a more dynamic "momentum" effect.
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuart);
  }

  Future<void> reveal({required Offset offset, required VoidCallback toggleTheme}) async {
    // Prevent overlapping animations if the user clicks rapidly
    if (_isAnimating) return;

    try {
      _isAnimating = true;

      // 1. Snapshot the OLD theme
      RenderRepaintBoundary boundary = _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);

      setState(() {
        _screenshot = image;
        _center = offset;
      });

      // 2. Flip the live app to the NEW theme (hidden under the screenshot)
      toggleTheme();

      // 3. Await the full 700ms expansion
      await _controller.forward(from: 0.0);

      setState(() {
        _screenshot = null;
        _isAnimating = false;
      });
      _controller.reset();
    } catch (e) {
      _isAnimating = false;
      toggleTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _repaintKey,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            textDirection: Directionality.maybeOf(context) ?? TextDirection.rtl,
            children: [
              // The real app (New Theme)
              widget.child,

              // The screenshot (Old Theme) being revealed pixel-by-pixel
              if (_screenshot != null)
                IgnorePointer(
                  child: ClipPath(
                    clipper: CircularRevealClipper(_animation.value, _center),
                    child: RawImage(image: _screenshot, fit: BoxFit.fill),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final Offset center;

  CircularRevealClipper(this.fraction, this.center);

  @override
  Path getClip(Size size) {
    // Finding the furthest corner from the tap point
    double maxRadius = [
      center.distance,
      (Offset(size.width, 0) - center).distance,
      (Offset(0, size.height) - center).distance,
      (Offset(size.width, size.height) - center).distance,
    ].reduce((a, b) => a > b ? a : b);

    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(center: center, radius: maxRadius * fraction))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
