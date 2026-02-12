import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gtr/core/widgets/icon_button.dart';
import 'package:gtr/core/widgets/text.dart';


class NavigationButton extends StatelessWidget {
  final bool isBack;
  final Function()? onTap;

  const NavigationButton({super.key, required this.isBack, this.onTap});

  @override
  Widget build(BuildContext context) {
    return isBack
        ? CustomIconButton(icon: Iconsax.arrow_right_1, backgroundColor: Colors.white, borderVisible: true, onPressed: context.pop)
        : GestureDetector(
            onTap: onTap ?? context.pop,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Color(0xFFE8EBEE)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(text: "Skip"),
                  SizedBox(width: 8),
                  Icon(Iconsax.arrow_right_1, size: 20),
                ],
              ),
            ),
          );
  }
}
