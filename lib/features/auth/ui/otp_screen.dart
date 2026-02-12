import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/utils/app_constants.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';

import '../../../core/utils/timer.dart';
import '../../../core/widgets/icon.dart';
import '../../../core/widgets/icon_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CountdownTimerMixin {
  @override
  void initState() {
    super.initState();
    startTimer(seconds: 60);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(), bottomNavigationBar: _buildBottomNavigationBar());
  }

  Widget _buildBody() {
    return SafeArea(
      child: ListView(
        padding: screenPadding,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          const CustomText(text: "Enter OTP Code", fontWeight: FontWeight.w800, fontSize: 22),
          const CustomText(text: "OTP code has been sent to +9647733062094", fontSize: 12),
          const SizedBox(height: 16),
          _buildOtpField(),
          const SizedBox(height: 16),
          _buildResendSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomIconButton(onPressed: () => context.pop(), icon: Iconsax.arrow_left, borderVisible: true),
          const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _buildOtpField() {
    final theme = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(color: theme.colorScheme.onSurface, fontFamily: fontFamily, fontSize: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EBEE)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(border: Border.all(color: theme.colorScheme.primary, width: 2)),
    );

    return Pinput(length: 4, defaultPinTheme: defaultPinTheme, focusedPinTheme: focusedPinTheme, onCompleted: (pin) {});
  }

  Widget _buildResendSection() {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomIcon(icon: Iconsax.repeate_music),
        TextButton(
          onPressed: canResend
              ? () {
                  startTimer(seconds: 60);
                }
              : null,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Resend Code: ",
                  style: TextStyle(color: theme.hintColor, fontFamily: fontFamily),
                ),
                TextSpan(
                  text: "${formattedTime}s",
                  style: TextStyle(fontWeight: FontWeight.w800, color: theme.primaryColor, fontFamily: fontFamily),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return SafeArea(
      child: Padding(
        padding: screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(onTap: () {}, title: "Submit"),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
