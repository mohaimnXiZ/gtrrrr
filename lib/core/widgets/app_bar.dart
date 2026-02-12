import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/widgets/text.dart';

import 'icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? color;
  final IconData? icon;
  final List<Widget>? actions;
  final double? titleSize;
  final double? leadingSize;
  final VoidCallback? onBackPressed;
  final bool isBackButtonVisible;
  final Color? titleColor;
  final bool center;

  const CustomAppBar({
    super.key,
    required this.title,
    this.color,
    this.icon = CupertinoIcons.forward,
    this.titleColor,
    this.actions,
    this.titleSize,
    this.leadingSize,
    this.onBackPressed,
    this.isBackButtonVisible = false,
    this.center = false
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: CustomText(text: title, fontWeight: FontWeight.w700, fontSize: titleSize ?? 20, color: titleColor),
      titleSpacing: isBackButtonVisible ? 0 : 12,
      centerTitle: center,
      backgroundColor: color,
      surfaceTintColor: Colors.transparent,
      actionsPadding: EdgeInsets.symmetric(horizontal: 12),
      actions: actions,
      leading: isBackButtonVisible
          ? CustomIconButton(icon: CupertinoIcons.back, size: leadingSize, onPressed: onBackPressed ?? () => context.pop())
          : null,
      automaticallyImplyLeading: false,
    );
  }
}
