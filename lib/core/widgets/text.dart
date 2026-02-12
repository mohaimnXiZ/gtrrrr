import 'package:flutter/material.dart';
import '../utils/app_constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxChars;
  final int? maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final TextDecoration? decoration;
  final double? height;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.maxChars,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.decoration,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxChars != null
          ? text.length > maxChars!
                ? text.substring(0, maxChars)
                : text
          : text,
      textAlign: textAlign,
      softWrap: true,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color,
        decoration: decoration,
        height: height,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}
