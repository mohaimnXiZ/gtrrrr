import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/controlled_height_screen.dart';
import 'package:gtr/core/widgets/icon_button.dart';
import 'package:gtr/core/widgets/local_image.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/core/widgets/text_fields.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/utils/app_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  bool _enabledButton = false;

  void _enableButton(String? value) {
    setState(() {
      _enabledButton = _email.text.isNotEmpty && _password.text.length >= 8 && _password.text.length >= 8 && _phone.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ControlledHeightScreen(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(),
                    _buildForm(),
                    _buildRegisterButton(),
                    _buildLoginText(),
                    _buildDivider(),
                    _buildSocialLogin(),
                  ],
                ),
                const SizedBox.shrink(),
              ],
            ),
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

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocalImage(img: "logo", type: "png", size: 48),
        SizedBox(height: 24),
        CustomText(text: "Register Your Account", fontWeight: FontWeight.w800, fontSize: 22),
        SizedBox(height: 8),
        CustomText(text: "Enter your information below", color: Theme.of(context).hintColor, fontSize: 12),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        CustomField(
          controller: _email,
          labelText: "Email Address",
          hintText: "Enter Email Address",
          onChanged: _enableButton,
          validator: (v) => (v == null || v.isEmpty) ? "Email cannot be empty" : null,
        ),
        SizedBox(height: 16),
        PhoneField(
          controller: _phone,
          labelText: "Phone Number",
          hintText: "Enter Phone Number",
          onChanged: _enableButton,
          validator: (v) {
            if (v == null || v.isEmpty) return "Phone number is required";
            RegExp regExp = RegExp(r"^(07[5789]\d{8}|7[5789]\d{8})$");
            if (!regExp.hasMatch(v)) return "Invalid Iraqi phone number";
            return null;
          },
        ),
        SizedBox(height: 16),
        CustomField(
          controller: _password,
          labelText: "Password",
          hintText: "Enter Password",
          obscureText: _obscureText,
          suffixWidget: IconButton(
            icon: Icon(_obscureText ? Iconsax.eye : Iconsax.eye_slash, color: Theme.of(context).hintColor),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
          onChanged: _enableButton,
          validator: (v) => (v == null || v.length < 8) ? "Password must be at least 8 characters" : null,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: 16),
        CustomField(
          controller: _confirmPassword,
          labelText: "Confirm Password",
          hintText: "Re-enter Password",
          obscureText: _obscureConfirmText,
          suffixWidget: IconButton(
            icon: Icon(_obscureConfirmText ? Iconsax.eye : Iconsax.eye_slash, color: Theme.of(context).hintColor),
            onPressed: () => setState(() => _obscureConfirmText = !_obscureConfirmText),
          ),
          textInputAction: TextInputAction.done,
          onChanged: _enableButton,
          validator: (v) {
            if (v != _password.text) return "Passwords do not match";
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return Column(
      children: [
        SizedBox(height: 24),
        CustomButton(
          // onTap: _enabledButton
          //     ? () {
          //         if (_formKey.currentState!.validate()) {
          //           context.push('/otp-method', extra: {'email': _email.text, 'phoneNumber': _phone.text});
          //         }
          //       }
          //     : () {},
          onTap: () {
            context.push('/otp-method', extra: {'email': "7738490654", 'phoneNumber': "ibrahim@gmail.com"});
          },
          title: "Register",
          color: _enabledButton ? Theme.of(context).primaryColor : Color(0xFFEDEDED),
          textColor: _enabledButton ? Colors.white : Color(0xFFA1A1A1),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildLoginText() {
    return Center(
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "Already have an account? ",
          style: TextStyle(fontFamily: fontFamily, fontSize: 14, color: Theme.of(context).hintColor, fontWeight: FontWeight.w400),
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  "Login Now",
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Divider(height: 0, color: Color(0xFFDFDFDF))),
          SizedBox(width: 8),
          CustomText(text: "Or Register With"),
          SizedBox(width: 8),
          Expanded(child: Divider(height: 0, color: Color(0xFFDFDFDF))),
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
}
