import 'package:flutter/material.dart';
import 'package:gtr/core/theme/app_colors.dart';
import 'package:gtr/core/widgets/app_bar.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/features/profile/component/policy_section.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Privacy Policy",center: true, isBackButtonVisible: true),
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
                text: "Please read these privacy policy, carefully before using our app operated by us.",
                fontSize: 16,
                maxLines: 4,
              ),
              PolicySection(
                title: "Privacy Policy",
                content:
                    "Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our application and services.\nWe collect information you provide directly when creating an account, making a booking, or contacting customer support. This may include your name, contact details, location, and payment-related information.\nYour information is used to provide and improve our services, process bookings, manage payments, communicate important updates, and ensure a safe and reliable experience.\nWe do not sell, trade, or rent your personal information to third parties. Information may only be shared with trusted service providers when necessary to operate the app, process payments, or comply with legal obligations.\nWe take appropriate security measures to protect your personal data from unauthorized access, alteration, or disclosure. However, no method of electronic storage or transmission is completely secure.\nOur app may use cookies or similar technologies to enhance functionality and improve user experience. You can control or disable cookies through your device settings.\nYour data is retained only for as long as necessary to fulfill the purposes outlined in this policy or as required by law.\nWe may update this Privacy Policy from time to time. Any changes will be reflected within the app, and continued use of the app indicates acceptance of the updated policy.\nIf you have any questions or concerns regarding this Privacy Policy, please contact our support team through the app.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
