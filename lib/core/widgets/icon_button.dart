import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? size;
  final Color? color;
  final AnimatedIconData? animatedIcon;
  final Animation<double>? progress;
  final Color? backgroundColor;
  final double? boxSize;
  final bool borderVisible;
  final bool disableSplash;

  const CustomIconButton({
    super.key,
    this.onPressed,
    this.icon,
    this.size,
    this.color,
    this.animatedIcon,
    this.progress,
    this.backgroundColor,
    this.boxSize,
    this.borderVisible = false,
    this.disableSplash = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: boxSize,
      width: boxSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderVisible
            ? Border.all(color: Theme.of(context).brightness == Brightness.light ? const Color(0xFFE8EBEE) : const Color(0xFF2B2B2B))
            : null,
      ),
      child: IconButton(
        onPressed: onPressed ?? () {},
        icon: animatedIcon != null && progress != null
            ? AnimatedIcon(
                icon: animatedIcon!,
                progress: progress!,
                size: size ?? 20,
                color: color ?? Theme.of(context).colorScheme.onSurface,
              )
            : Icon(icon ?? Iconsax.info_circle, size: size ?? 20, color: color ?? Theme.of(context).colorScheme.onSurface),
        style: IconButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor ?? Colors.transparent,
          overlayColor: disableSplash ? Colors.transparent : null,
        ),
      ),
    );
  }
}
