import 'package:flutter/material.dart';

import '../../../core/widgets/local_image.dart';
import '../../../core/widgets/text.dart';

class ProfileMenuTile extends StatelessWidget {
  final String title;
  final String iconName;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showDivider;

  // Color Options
  final Color titleColor;
  final Color? iconColor;       // If null, uses original SVG colors or titleColor
  final Color containerColor;   // The background circle color

  const ProfileMenuTile({
    super.key,
    required this.title,
    required this.iconName,
    this.onTap,
    this.trailing,
    this.showDivider = true,
    this.titleColor = const Color(0xFF060812),
    this.iconColor,
    this.containerColor = const Color(0xFFF7F7F7), // Default light grey
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // Ensures the InkWell ripple is visible
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // Icon Container
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: containerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: LocalImage(
                        img: iconName,
                        // Use provided iconColor, fallback to titleColor
                        color: iconColor ?? titleColor,
                        type: "svg",
                        height: 20,
                        width: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Title
                  Expanded(
                    child: CustomText(
                      text: title,
                      fontSize: 14,
                      color: titleColor, // Applied to text
                    ),
                  ),

                  // Trailing (Switch or Arrow)
                  trailing ?? const LocalImage(img: "arrow", type: "svg", size: 14),
                ],
              ),
            ),
          ),
          if (showDivider)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Theme.of(context).dividerColor,
                height: 1,
              ),
            ),
        ],
      ),
    );
  }
}