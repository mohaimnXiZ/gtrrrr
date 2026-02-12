import 'package:flutter/material.dart';

class BouncingDotsLoader extends StatefulWidget {
  final double dotSize;
  final Color dotColor;
  final Duration duration;
  final double spacing;

  const BouncingDotsLoader({
    super.key,
    this.dotSize = 5.0,
    this.dotColor = const Color(0xFFFFFFFF),
    this.duration = const Duration(milliseconds: 750),
    this.spacing = 1.5,
  });

  @override
  State<BouncingDotsLoader> createState() => _BouncingDotsLoaderState();
}

class _BouncingDotsLoaderState extends State<BouncingDotsLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();

    _animations = List.generate(4, (index) {
      final delay = index * 0.15;
      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: -5.0).chain(CurveTween(curve: Curves.easeOut)), weight: 25),
        TweenSequenceItem(tween: Tween<double>(begin: -5.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), weight: 25),
        TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 50),
      ]).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(delay, 1.0, curve: Curves.linear),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animations[index].value),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: widget.spacing),
                width: widget.dotSize,
                height: widget.dotSize,
                decoration: BoxDecoration(color: widget.dotColor, shape: BoxShape.circle),
              ),
            );
          },
        );
      }),
    );
  }
}
