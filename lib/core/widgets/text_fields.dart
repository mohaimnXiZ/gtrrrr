import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gtr/core/widgets/text.dart';

import '../utils/app_constants.dart';
import 'icon.dart';
import 'icon_button.dart';
import 'local_image.dart';

class ArabicToEnglishNumeralFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final arabicToEnglish = {'٠': '0', '١': '1', '٢': '2', '٣': '3', '٤': '4', '٥': '5', '٦': '6', '٧': '7', '٨': '8', '٩': '9'};

    String convertedText = text;
    arabicToEnglish.forEach((arabic, english) {
      convertedText = convertedText.replaceAll(arabic, english);
    });

    // If text changed, update the value
    if (convertedText != text) {
      return TextEditingValue(
        text: convertedText,
        selection: TextSelection.collapsed(offset: newValue.selection.baseOffset),
      );
    }

    return newValue;
  }
}

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String icon;
  final String labelText;
  final Color? labelColor;
  final FontWeight labelWeight;
  final double labelSize;
  final bool showLabel;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? suffixIcon;
  final bool isRequired;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final Function(String)? onChanged;

  const PhoneField({
    super.key,
    required this.controller,
    this.hintText = "07xx xxx xxxx",
    this.inputFormatters,
    this.icon = "phone",
    this.labelText = "رقم الهاتف",
    this.labelColor,
    this.labelWeight = FontWeight.w400,
    this.labelSize = 12,
    this.showLabel = true,
    this.validator,
    this.errorText,
    this.suffixIcon,
    this.textInputAction,
    this.isRequired = true,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: labelText,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: labelSize,
                    fontWeight: labelWeight,
                    color: labelColor ?? Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],

        Directionality(
          textDirection: TextDirection.ltr,
          child: TextFormField(
            onChanged: onChanged,
            readOnly: readOnly,
            textInputAction: textInputAction ?? TextInputAction.next,
            controller: controller,
            keyboardType: TextInputType.phone,
            inputFormatters: [ArabicToEnglishNumeralFormatter(), ...?inputFormatters],
            validator:
                validator ??
                (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "يرجى إدخال رقم الهاتف";
                  }
                  final phoneRegex = RegExp(r'^(077|078|075)\d{8}$');
                  if (!phoneRegex.hasMatch(value.trim().replaceAll(RegExp(r'[\s-]'), ''))) {
                    return "يرجى إدخال رقم هاتف صحيح (077/078/075 xxxxxxxx)";
                  }
                  return null;
                },
            style: TextStyle(fontFamily: fontFamily, fontSize: 14),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(fontFamily: fontFamily, color: Theme.of(context).hintColor, fontSize: 12),
              errorText: errorText,
              errorStyle: TextStyle(fontFamily: fontFamily, color: Theme.of(context).colorScheme.error, fontSize: 16),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 18, right: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(text: "+964", color: Theme.of(context).hintColor),
                    const SizedBox(width: 8),
                    SizedBox(height: 36, child: VerticalDivider(color: Theme.of(context).hintColor.withAlpha(64), thickness: 1)),
                  ],
                ),
              ),
              suffixIcon: suffixIcon != null && suffixIcon!.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(right: 12, left: 8),
                      child: LocalImage(img: "call", type: "svg", height: 24, width: 24),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Theme.of(context).hintColor.withAlpha(128), width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Theme.of(context).hintColor.withAlpha(128), width: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 0.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomField extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final String? icon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  final String labelText;
  final Color? labelColor;
  final FontWeight labelWeight;
  final double labelSize;
  final bool showLabel;

  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? hintColor;

  final bool obscureText;
  final bool isDropDown;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? errorText;
  final bool isRequired;
  final TextInputAction? textInputAction;
  final Color? cursorColor;
  final Color? textColor;
  const CustomField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.icon,
    this.prefixWidget,
    this.labelText = "",
    this.labelColor,
    this.labelWeight = FontWeight.w400,
    this.labelSize = 12,
    this.showLabel = true,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    this.borderRadius = 16,
    this.borderColor,
    this.focusedBorderColor,
    this.hintColor,
    this.suffixWidget,
    this.obscureText = false,
    this.isDropDown = false,
    this.onTap,
    this.onChanged,
    this.validator,
    this.errorText,
    this.isRequired = true,
    this.textInputAction, this.cursorColor, this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel && labelText.isNotEmpty) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: labelText,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: labelSize,
                    fontWeight: labelWeight,
                    color: labelColor ?? theme.hintColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],

        TextFormField(
          cursorColor: cursorColor,
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.next,
          onTap: isDropDown ? onTap : null,
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters ?? [],
          obscureText: obscureText,
          readOnly: isDropDown,
          validator: validator,
          style: TextStyle(fontFamily: fontFamily, fontSize: 14, color: textColor),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontFamily: fontFamily, color: hintColor ?? theme.hintColor, fontSize: 12, fontWeight: FontWeight.w400),
            errorText: errorText,
            errorStyle: TextStyle(fontFamily: fontFamily, color: theme.colorScheme.error, fontSize: 12),
            prefixIcon:
                prefixWidget ??
                (icon != null
                    ? Padding(
                        padding: EdgeInsets.only(right: 12, left: 8),
                        child: LocalImage(img: icon!, type: "svg", height: 24, width: 24),
                      )
                    : null),

            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: isDropDown ? CustomIcon(icon: Iconsax.arrow_down_1, color: Theme.of(context).hintColor, size: 16) : suffixWidget,
            contentPadding: contentPadding,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor ?? theme.hintColor.withAlpha(120), width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor ?? theme.hintColor.withAlpha(120), width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: focusedBorderColor ?? theme.primaryColor, width: 0.7),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: theme.colorScheme.error, width: 0.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: theme.colorScheme.error, width: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onClose;
  final double collapsedWidth;
  final Duration animationDuration;
  final Curve animationCurve;

  const AnimatedSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = "إبحث",
    this.onSubmitted,
    this.onSearchPressed,
    this.onClose,
    this.collapsedWidth = 42,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeInOutCubicEmphasized,
  });

  @override
  State<AnimatedSearchField> createState() => _AnimatedSearchFieldState();
}

class _AnimatedSearchFieldState extends State<AnimatedSearchField> with SingleTickerProviderStateMixin {
  late TextEditingController _internalController;
  late FocusNode _internalFocusNode;
  late AnimationController _contentAnimationController;
  late Animation<double> _contentFadeAnimation;
  late Animation<Offset> _contentSlideAnimation;
  bool _isSearchExpanded = false;

  TextEditingController get _controller => widget.controller ?? _internalController;

  FocusNode get _focusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalController = TextEditingController();
    _internalFocusNode = FocusNode();
    _contentAnimationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _contentFadeAnimation = CurvedAnimation(parent: _contentAnimationController, curve: widget.animationCurve);
    _contentSlideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _contentAnimationController, curve: widget.animationCurve));
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    _contentAnimationController.dispose();
    super.dispose();
  }

  void _closeSearch() {
    _contentAnimationController.reverse().then((_) {
      setState(() {
        _isSearchExpanded = false;
        _controller.clear();
      });
      widget.onClose?.call();
    });
  }

  void _openSearch() {
    if (!_isSearchExpanded) {
      setState(() {
        _isSearchExpanded = true;
      });
      Future.delayed(const Duration(milliseconds: 50), () {
        _contentAnimationController.forward();
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        _focusNode.requestFocus();
      });
      widget.onSearchPressed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          width: _isSearchExpanded ? constraints.maxWidth : widget.collapsedWidth,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).brightness == Brightness.light ? Color(0xFFE8EBEE) : Color(0xFF2B2B2B)),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isSearchExpanded && !isRTL) Expanded(child: _buildSearchTextField(context, isRTL: false)),
              CustomIconButton(icon: Iconsax.search_normal, borderVisible: false, onPressed: _openSearch),
              if (_isSearchExpanded && isRTL) Expanded(child: _buildSearchTextField(context, isRTL: true)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchTextField(BuildContext context, {required bool isRTL}) {
    return FadeTransition(
      opacity: _contentFadeAnimation,
      child: SlideTransition(
        position: isRTL
            ? Tween<Offset>(
                begin: const Offset(-0.3, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(parent: _contentAnimationController, curve: widget.animationCurve))
            : _contentSlideAnimation,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: fontFamily, color: Theme.of(context).colorScheme.onSurface, fontSize: 14),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontFamily: fontFamily, color: Theme.of(context).hintColor, fontSize: 14),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: FadeTransition(
              opacity: _contentFadeAnimation,
              child: Transform.rotate(
                angle: 45 * pi / 180,
                child: CustomIconButton(icon: Iconsax.add, size: 20, borderVisible: false, onPressed: _closeSearch, disableSplash: true),
              ),
            ),
          ),
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }
}
