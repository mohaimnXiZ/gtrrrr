import 'package:flutter/material.dart';
import 'package:gtr/core/widgets/app_bar.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/text_fields.dart';

import '../../../core/widgets/local_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile", isBackButtonVisible: true,),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: (){},
                customBorder: const CircleBorder(),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      SizedBox(
                        child: LocalImage(img: "profile", type: "png", height: 100),
                      ),
                      Align(
                        child: LocalImage(img: "camera", type: "svg", color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField(labelText: "Name", hintText: "Enter Name", controller: _nameController,
                    validator: (v) {
                      if(_nameController.text.isEmpty){
                        return "name is required";
                      }
                      if(_nameController.text.length > 30){
                        return "the name must be between 1 and 30 characters";
                      } else {
                        return null;
                      }
                    },),
                    SizedBox(height: 16),
                    CustomField(
                      labelText: "Email Address",
                      hintText: "enter Email",
                      controller: _emailController,
                      validator: (v){
                        if(_emailController.text.isEmpty){
                          return "email is required";
                        }
                        else if(!_emailController.text.contains("@gmail.com")){
                          return "enter a valid email adress";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    CustomField(
                      keyboardType: TextInputType.number,
                      labelText: "Phone Number",
                      hintText: "enter Phone Number",
                      controller: _phoneController,
                      validator: (v) {
                        if(_phoneController.text.isEmpty){
                          return "phone number is required";
                        } else if(_phoneController.text.length != 11){
                          return "phone number must be 11 numbers";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(title: "update", onTap: () {
                _formKey.currentState?.validate();
              }),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
