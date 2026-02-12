import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/utils/app_constants.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/local_image.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/core/widgets/text_fields.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/widgets/icon_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _enabledButton = false;

  void _validateForm(String? value) {
    setState(() {
      _enabledButton = _password.text.length >= 8 && _confirmPassword.text.length >= 8;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: screenPadding,
            children: [_buildHeader(), const SizedBox(height: 24), _buildTitleSection(), _buildForm()],
          ),
        ),
      ),
      bottomNavigationBar: _buildSubmitButton(),
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
        const CustomText(text: "Enter New Password", fontWeight: FontWeight.w800, fontSize: 22),
        CustomText(text: "Please enter your new password", color: Theme.of(context).hintColor, fontSize: 12),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        CustomField(
          controller: _password,
          onChanged: _validateForm,
          labelText: "New Password",
          hintText: "Enter New Password",
          obscureText: _obscurePassword,
          validator: (v) => (v == null || v.length < 8) ? "Password must be at least 8 characters" : null,
          suffixWidget: IconButton(
            icon: Icon(_obscurePassword ? Iconsax.eye : Iconsax.eye_slash, color: Theme.of(context).hintColor),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        const SizedBox(height: 16),
        CustomField(
          controller: _confirmPassword,
          onChanged: _validateForm,
          labelText: "Confirm Password",
          hintText: "Re-enter New Password",
          obscureText: _obscureConfirm,
          textInputAction: TextInputAction.done,
          validator: (v) {
            if (v == null || v.isEmpty) return "Please confirm your password";
            if (v != _password.text) return "Passwords do not match";
            return null;
          },
          suffixWidget: IconButton(
            icon: Icon(_obscureConfirm ? Iconsax.eye : Iconsax.eye_slash, color: Theme.of(context).hintColor),
            onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SafeArea(
      child: Padding(
        padding: screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              onTap: _showSuccessBottomSheet,
              // onTap: _enabledButton
              //     ? () {
              //         if (_formKey.currentState!.validate()) {
              //           context.go("/login");
              //         }
              //       }
              //     : () {},
              title: "Reset Password",
              color: _enabledButton ? Theme.of(context).primaryColor : const Color(0xFFEDEDED),
              textColor: _enabledButton ? Colors.white : const Color(0xFFA1A1A1),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showSuccessBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LocalImage(img: "success-asset", type: "png", size: 100),
                SizedBox(height: 16),
                CustomText(
                  text: "Password Update Successfully",
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 8),
                CustomText(
                  text: "Your password has been updated successfully\n You can safely continue",
                  fontSize: 12,
                  color: Theme.of(context).hintColor,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                CustomButton(onTap: () {}, title: "Back to Home"),
              ],
            ),
          ),
        );
      },
    );
  }
}
