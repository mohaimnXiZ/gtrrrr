import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/widgets/controlled_height_screen.dart';
import '../../../core/widgets/loading.dart';
import '../../../core/widgets/local_image.dart';
import '../../../core/widgets/text.dart';
import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      final String? token = preferences?.getString('token');

      context.go('/main');

      // if (token != null && token.isNotEmpty) {
      //   context.go('/home');
      // } else {
      //   context.go('/landing');
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ControlledHeightScreen(
          padding: screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [const SizedBox.shrink(), _buildLogoSection(), _buildFooterSection(context)],
          ),
        ),
      ),
    );
  }

  // --- UI Methods ---

  Widget _buildLogoSection() {
    return Center(
      child: Column(
        children: const [
          LocalImage(img: "logo", type: "png", size: 100),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFooterSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Column(
        children: [
          const CustomText(text: "2026 by Vodex Tech", fontWeight: FontWeight.w400, fontSize: 12),
          const CustomText(text: "V.1.0", fontWeight: FontWeight.w400, fontSize: 12),
          const SizedBox(height: 24),
          BouncingDotsLoader(dotSize: 6, dotColor: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
