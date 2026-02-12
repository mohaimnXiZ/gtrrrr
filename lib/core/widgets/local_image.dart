import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocalImage extends StatefulWidget {
  final String img;
  final String type;
  final double? size;
  final double? height;
  final double? width;
  final Color? color;
  final double borderRadius;
  final BorderRadius? alternativeBorderRadius;
  final AlignmentGeometry alignment;
  final BoxFit fit;
  final bool isFileImage;

  const LocalImage({
    required this.img,
    required this.type,
    this.height,
    this.size,
    this.borderRadius = 0,
    this.width,
    this.color,
    this.alignment = FractionalOffset.center,
    this.fit = BoxFit.fitHeight,
    this.isFileImage = false,
    super.key, this.alternativeBorderRadius,
  });

  @override
  State<LocalImage> createState() => _CustomImageAssetsState();
}

class _CustomImageAssetsState extends State<LocalImage> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.alternativeBorderRadius ?? BorderRadius.circular(widget.borderRadius),
      child: widget.isFileImage != true
          ? widget.type == "svg"
                ? SvgPicture.asset(
                    "assets/images/svg/${widget.img}.svg",
                    height: widget.size ?? widget.height,
                    width: widget.size ?? widget.width,
                    fit: widget.fit,
                    colorFilter: widget.color != null ? ColorFilter.mode(widget.color!, BlendMode.srcIn) : null,
                  )
                : Image.asset(
                    "assets/images/png/${widget.img}.png",
                    height: widget.size ?? widget.height,
                    width: widget.size ?? widget.width,
                    fit: widget.fit,
                    alignment: widget.alignment,
                  )
          : Image.file(File(widget.img), height: widget.height, width: widget.width, fit: widget.fit, alignment: widget.alignment),
    );
  }
}
