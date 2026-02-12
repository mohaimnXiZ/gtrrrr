import 'package:flutter/material.dart';

import 'loading.dart';
import 'text.dart';

class CustomButton extends StatelessWidget {
  final bool loading;
  final String? title;
  final Widget? child;
  final Color? color;
  final Color? textColor;
  final double width;
  final double verticalPadding;
  final FontWeight? fontWeight;
  final Color borderColor;
  final Function()? onTap;
  final Color? loadingColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final double textSize;

  const CustomButton({
    super.key,
    this.loading = false,
    this.color,
    this.textColor,
    this.title,
    required this.onTap,
    this.fontWeight,
    this.borderColor = Colors.transparent,
    this.width = 100000,
    this.verticalPadding = 16,
    this.child,
    this.loadingColor,
    this.borderWidth,
    this.borderRadius,
    this.textSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 350);

    const curve = Curves.fastOutSlowIn;

    return AnimatedContainer(
      duration: duration,
      curve: curve,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(100),
        border: Border.all(color: borderColor, width: borderWidth ?? 0.5),
        boxShadow: [BoxShadow(color: (color ?? Theme.of(context).primaryColor).withAlpha(26), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: !loading ? onTap : null,
          borderRadius: borderRadius ?? BorderRadius.circular(100),
          splashColor: Colors.white.withAlpha(26),
          highlightColor: Colors.transparent,
          child: !loading
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: verticalPadding),
                  child:
                      child ??
                      AnimatedDefaultTextStyle(
                        duration: duration,
                        curve: curve,
                        style: TextStyle(color: textColor ?? Colors.white, fontSize: textSize, fontWeight: fontWeight ?? FontWeight.bold),
                        child: Center(
                          child: CustomText(
                            text: title!,
                            color: textColor ?? Colors.white,
                            fontSize: textSize,
                            fontWeight: fontWeight ?? FontWeight.bold,
                          ),
                        ),
                      ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 21),
                  child: BouncingDotsLoader(dotColor: loadingColor ?? Colors.white),
                ),
        ),
      ),
    );
  }
}
