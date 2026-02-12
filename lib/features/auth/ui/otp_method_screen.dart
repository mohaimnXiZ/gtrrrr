import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/utils/app_constants.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/controlled_height_screen.dart';
import 'package:gtr/core/widgets/icon.dart';
import 'package:gtr/core/widgets/local_image.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/widgets/icon_button.dart';

class OtpMethodScreen extends StatefulWidget {
  final String email;
  final String phoneNumber;

  const OtpMethodScreen({super.key, required this.email, required this.phoneNumber});

  @override
  State<OtpMethodScreen> createState() => _OtpMethodScreenState();
}

class _OtpMethodScreenState extends State<OtpMethodScreen> {
  String _method = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ControlledHeightScreen(
          padding: screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              _buildAsset(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSmsMethod(),
                  const SizedBox(height: 20),
                  _buildEmailMethod(),
                  const SizedBox(height: 20),
                  _buildSubmitButton(),
                  const SizedBox(height: 20),
                  _buildLoginText(),
                  _buildDivider(),
                  _buildSocialLogin(),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
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
          const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildAsset() {
    return LocalImage(img: "lock-asset", type: "png", size: 128);
  }

  Widget _buildSmsMethod() {
    return _buildMethodContainer(
      context,
      onTap: () {
        setState(() {
          if (_method == "sms") {
            _method = "";
          } else {
            _method = "sms";
          }
        });
      },
      title: "Send OTP via SMS",
      description: widget.phoneNumber,
      type: "sms",
      isSelected: _method == "sms",
    );
  }

  Widget _buildEmailMethod() {
    return _buildMethodContainer(
      context,
      onTap: () {
        setState(() {
          if (_method == "email") {
            _method = "";
          } else {
            _method = "email";
          }
        });
      },
      title: "Send OTP via Email",
      description: widget.email,
      type: "email",
      isSelected: _method == "email",
    );
  }

  Widget _buildSubmitButton() {
    return CustomButton(
      // onTap: _method.isNotEmpty ? () {} : () {},
      onTap: () => context.push("/otp"),
      width: MediaQuery.of(context).size.width * 0.8,
      title: "Send OTP",
      color: _method.isNotEmpty ? Theme.of(context).primaryColor : Color(0xFFEDEDED),
      textColor: _method.isNotEmpty ? Colors.white : Color(0xFFA1A1A1),
    );
  }

  Widget _buildLoginText() {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: "Already have an account? ",
        style: TextStyle(fontFamily: fontFamily, fontSize: 14, color: Theme.of(context).hintColor, fontWeight: FontWeight.w400),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Text(
                "Login",
                style: TextStyle(fontFamily: fontFamily, fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          Expanded(child: Divider(height: 0, color: Color(0xFFDFDFDF))),
          SizedBox(width: 8),
          CustomText(text: "Or Login With"),
          SizedBox(width: 8),
          Expanded(child: Divider(height: 0, color: Color(0xFFDFDFDF))),
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      children: [
        Flexible(
          child: CustomButton(
            onTap: () {},
            color: Color(0xFFF7F7F7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                LocalImage(img: "google", type: "png", size: 24),
                SizedBox(width: 12),
                Flexible(child: CustomText(text: "Google")),
              ],
            ),
          ),
        ),
        SizedBox(width: 12),
        Flexible(
          child: CustomButton(
            onTap: () {},
            color: Color(0xFFF7F7F7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                LocalImage(img: "apple", type: "png", size: 24),
                SizedBox(width: 12),
                Flexible(child: CustomText(text: "Apple")),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMethodContainer(
    BuildContext context, {
    required Function() onTap,
    required String title,
    required String description,
    required String type,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    const duration = Duration(milliseconds: 350);
    const curve = Curves.fastOutSlowIn;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? theme.primaryColor : const Color(0xFFDFDFDF), width: isSelected ? 1.5 : 1.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: duration,
              curve: curve,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? theme.primaryColor : const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(100),
              ),
              child: CustomIcon(
                icon: type == "sms" ? Iconsax.message_text_1 : Iconsax.sms,
                color: isSelected ? Colors.white : const Color(0xFFA1A1A1),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: title, color: theme.hintColor, fontSize: 12),
                  CustomText(text: description, fontSize: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
