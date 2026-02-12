import 'package:flutter/material.dart';

import '../../../core/widgets/text.dart';

class PolicySection extends StatelessWidget {
  final String title;
  final String content;
  final Color titleColor;
  final Color contentColor;
  final double verticalPadding;

  const PolicySection({
    super.key,
    required this.title,
    required this.content,
    this.titleColor = const Color(0xFF9C0606),
    this.contentColor = const Color(0xFF7B7B7B),
    this.verticalPadding = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: titleColor,
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          CustomText(
            text: content,
            maxLines: 200,
            fontSize: 14, // Slightly smaller often looks better for body text
            color: contentColor,
          ),
        ],
      ),
    );
  }
}