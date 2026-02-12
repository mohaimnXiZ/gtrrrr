import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;
  final Duration duration;

  const CustomIcon({super.key, required this.icon, this.color, this.size, this.duration = const Duration(milliseconds: 350)});

  @override
  Widget build(BuildContext context) {
    final targetColor = color ?? Theme.of(context).colorScheme.onSurface;
    final targetSize = size ?? 24.0;

    return TweenAnimationBuilder<Color?>(
      duration: duration,
      curve: Curves.fastOutSlowIn,
      tween: ColorTween(begin: targetColor, end: targetColor),
      builder: (context, animatedColor, child) {
        return TweenAnimationBuilder<double>(
          duration: duration,
          tween: Tween<double>(begin: targetSize, end: targetSize),
          builder: (context, animatedSize, child) {
            return Icon(icon, size: animatedSize, color: animatedColor);
          },
        );
      },
    );
  }
}
