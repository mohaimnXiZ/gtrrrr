import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/theme/app_colors.dart';
import 'package:gtr/core/widgets/app_bar.dart';
import 'package:gtr/core/widgets/local_image.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/features/profile/component/menu_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(
        title: "My Profile",
        titleColor: AppColors.secondaryLight,
        center: true,
        color: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.74,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 56),
                      CustomText(text: "Ahmadz Al Bahrani", fontSize: 16, fontWeight: FontWeight.w700),
                      CustomText(
                        text: "Ahmad Al Bahrani@example.com",
                        fontSize: 14,
                        color: AppColors.textSecondaryLight,
                      ),
                      SizedBox(height: 42),
                      Expanded(
                        child: ListView(
                          children: [
                            ProfileMenuTile(
                              title: "Profile Information",
                              iconName: "profile-vector",
                              onTap: () {
                                context.push('/edit-profile');
                              },
                            ),
                            ProfileMenuTile(
                              title: "Privacy Policy",
                              iconName: "shield",
                              onTap: () {
                                context.push('/privacy');
                              },
                            ),
                            ProfileMenuTile(
                              title: "Terms & Conditions",
                              iconName: "list",
                              onTap: () {
                                context.push('/terms');
                              },
                            ),
                            ProfileMenuTile(
                              title: "Dark Mode",
                              iconName: "moon",
                              onTap: () {
                                setState(() {
                                  switchValue = !switchValue;
                                });
                              },
                              trailing: Switch(
                                value: switchValue,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.grey.withAlpha(200),
                                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                  if (!states.contains(WidgetState.selected)) {
                                    return Colors.white;
                                  }
                                  return null;
                                }),
                                onChanged: (v) {
                                  setState(() {
                                    switchValue = v;
                                  });
                                },
                              ),
                            ),
                            ProfileMenuTile(
                              title: "Logout",
                              titleColor: Color(0xFFEF4444),
                              containerColor: Color(0xFFEF4444).withAlpha(100),
                              iconColor: Color(0xFFEF4444),
                              iconName: "logout",
                              onTap: () {},
                              showDivider: false,
                              trailing: SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: (MediaQuery.of(context).size.height * 0.74) - 50,
              left: 0,
              right: 0,
              child: SizedBox(
                child: LocalImage(img: "profile", type: "png", height: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
