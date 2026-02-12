import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/controlled_height_screen.dart';
import 'package:gtr/core/widgets/local_image.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/core/widgets/text_fields.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/utils/app_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? _remember = false;
  bool _obscureText = true;
  bool _enabledButton = false;

  void _enableButton(String? value) {
    setState(() {
      _enabledButton = _email.text.isNotEmpty && _password.text.length >= 8;
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
                const SizedBox.shrink(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(),
                    _buildForm(),
                    _buildRememberForgot(),
                    _buildLoginButton(),
                    _buildRegisterText(),
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

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocalImage(img: "logo", type: "png", size: 48),
        SizedBox(height: 24),
        CustomText(text: "Let’s Get You Login", fontWeight: FontWeight.w800, fontSize: 22),
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
          onChanged: _enableButton,
          labelText: "Email Address",
          hintText: "Enter Email Address",
          validator: (v) => (v == null || v.isEmpty) ? "Email cannot be empty" : null,
        ),
        SizedBox(height: 16),
        CustomField(
          controller: _password,
          onChanged: _enableButton,
          labelText: "Password",
          hintText: "Enter Password",
          obscureText: _obscureText,
          validator: (v) => (v == null || v.length < 8) ? "Password is too short" : null,
          suffixWidget: IconButton(
            icon: Icon(_obscureText ? Iconsax.eye : Iconsax.eye_slash, color: Theme.of(context).hintColor),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _buildRememberForgot() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _remember,
                    side: BorderSide(color: Color(0xFFDFDFDF)),
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    onChanged: (value) => setState(() => _remember = value),
                  ),
                ),
                SizedBox(width: 4),
                Flexible(child: const CustomText(text: "Remember me", fontSize: 14)),
              ],
            ),
          ),
          Flexible(
            child: InkWell(
              onTap: () => context.push("/reset-password"),
              borderRadius: BorderRadius.circular(100),
              child: CustomText(text: "Forgot Password?", fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Column(
      children: [
        SizedBox(height: 12),
        CustomButton(
          onTap: _enabledButton
              ? () {
                  if (_formKey.currentState!.validate()) {}
                }
              : () {},
          title: "Login",
          color: _enabledButton ? Theme.of(context).primaryColor : Color(0xFFEDEDED),
          textColor: _enabledButton ? Colors.white : Color(0xFFA1A1A1),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildRegisterText() {
    return Center(
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "Don’t have an account? ",
          style: TextStyle(fontFamily: fontFamily, fontSize: 14, color: Theme.of(context).hintColor, fontWeight: FontWeight.w400),
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: GestureDetector(
                onTap: () {
                  context.push("/register");
                },
                child: Text(
                  "Register Now",
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
}
