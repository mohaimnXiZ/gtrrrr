import 'package:flutter/material.dart';
import 'package:gtr/core/theme/app_colors.dart';
import 'package:gtr/core/widgets/app_bar.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/features/profile/component/policy_section.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Terms & Conditions",center: true, isBackButtonVisible: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              CustomText(
                text: "Last update: Dec 18, 2025",
                fontSize: 14,
                color: AppColors.textSecondaryLight,
                maxLines: 2,
              ),
              SizedBox(height: 8),
              CustomText(
                text: "Please read these terms of service, carefully before using the app.",
                fontSize: 16,
                maxLines: 4,
              ),
              PolicySection(
                title: "Conditions of Uses",
                content:
                    "By accessing and using this application, you agree to comply with these Terms & Conditions. If you do not agree with any part of these terms, please do not use the app or its services.",
              ),
              PolicySection(
                title: "Service Description",
                content:
                    "The app provides luxury car services with professional drivers for airport transfers, hourly bookings, corporate travel, and special occasions. All services are subject to availability and confirmation.",
              ),
              PolicySection(
                title: "User Responsibilities",
                content:
                    "Users are responsible for providing accurate information during booking. Any damage caused to vehicles or violation of usage rules may result in additional charges. Personal belongings remain the responsibility of the user.",
              ),
              PolicySection(
                title: "Liability & Delays",
                content:
                    "We are not responsible for delays caused by traffic, weather conditions, accidents, or circumstances beyond our control. All vehicles are insured in accordance with local regulations.",
              ),
              PolicySection(
                title: "Contact & Support",
                content: "For questions or assistance, please contact customer support through the app.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
