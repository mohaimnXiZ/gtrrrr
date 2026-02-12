import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gtr/core/widgets/icon.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double radius;
  final double? height;
  final double? width;
  final double onEmptyIconSize;
  final IconData? onEmptyIconData;
  final Color? backgroundColor;
  final Color? errorColor;
  final BoxFit fit;

  const CustomNetworkImage({
    super.key,

    required this.url,
    this.radius = 3,
    this.height,
    this.width,
    this.onEmptyIconSize = 2.5,
    this.onEmptyIconData,
    this.fit = BoxFit.cover,
    this.errorColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, imageProvider) => Container(
            height: height ?? constraints.maxHeight,
            width: width ?? constraints.maxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(image: imageProvider, fit: fit),
            ),
          ),
          placeholder: (context, url) => Container(
            height: height ?? constraints.maxHeight,
            width: width ?? constraints.maxWidth,
            color: backgroundColor ?? Theme.of(context).colorScheme.surface,
            child: SizedBox.shrink(),
          ),
          errorWidget: (context, url, error) {
            return Container(
              height: height ?? constraints.maxHeight,
              width: width ?? constraints.maxWidth,
              color: backgroundColor ?? Theme.of(context).colorScheme.surface,
              child: CustomIcon(icon: Iconsax.info_circle, color: Theme.of(context).colorScheme.error),
            );
          },
        );
      },
    );
  }
}
