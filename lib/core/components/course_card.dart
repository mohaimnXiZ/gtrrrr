import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/widgets/network_image.dart';

import '../widgets/text.dart';

class CourseCard extends StatelessWidget {
  final Function()? onTap;
  final String image;
  final String title;
  final String subtitle;

  const CourseCard({super.key, required this.image, required this.title, required this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/details");
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(aspectRatio: 1.25, child: CustomNetworkImage(url: image)),
          const SizedBox(height: 8),
          CustomText(text: title, fontWeight: FontWeight.w600),
          CustomText(text: subtitle, color: Theme.of(context).hintColor, fontSize: 12),
        ],
      ),
    );
  }
}
