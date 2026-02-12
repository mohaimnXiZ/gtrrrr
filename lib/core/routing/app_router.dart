import 'package:flutter/material.dart';
import 'package:gtr/core/routing/routing_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/features/auth/ui/login_screen.dart';
import 'package:gtr/features/auth/ui/otp_method_screen.dart';
import 'package:gtr/features/auth/ui/otp_screen.dart';
import 'package:gtr/features/auth/ui/register_screen.dart';
import 'package:gtr/features/auth/ui/reset_password_screen.dart';
import 'package:gtr/features/home/ui/all_categories_screen.dart';
import 'package:gtr/features/main/ui/boarding_screen.dart';
import 'package:gtr/features/main/ui/main_screen.dart';
import 'package:gtr/features/profile/ui/privacy_policy_screen.dart';
import 'package:gtr/features/profile/ui/profile_screen.dart';
import 'package:gtr/features/profile/ui/terms_and_conditions_screen.dart';

import '../../features/home/ui/home_screen.dart';
import '../../features/main/ui/splash_screen.dart';
import '../../features/profile/ui/edit_profile_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const SplashScreen(), transition: homeScreenWithOverlayResponse);
      },
    ),
    GoRoute(
      path: '/boarding',
      name: 'boarding',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const BoardingScreen(), transition: homeScreenWithOverlayResponse);
      },
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const LoginScreen(), transition: fadeSlideLR);
      },
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const RegisterScreen(), transition: fadeSlideLR);
      },
    ),
    GoRoute(
      path: '/reset-password',
      name: 'reset-password',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const ResetPasswordScreen(), transition: fadeSlideLR);
      },
    ),
    GoRoute(
      path: '/otp-method',
      name: 'otp-method',
      pageBuilder: (context, state) {
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        return buildPage(
          key: state.pageKey,
          child: OtpMethodScreen(email: extra['email'] ?? "", phoneNumber: extra['phoneNumber'] ?? ""),
          transition: fadeSlideLR,
        );
      },
    ),
    GoRoute(
      path: '/otp',
      name: 'otp',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const OtpScreen(), transition: fadeSlideLR);
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const HomeScreen(), transition: fadeSlideLR);
      },
    ),GoRoute(
      path: '/main',
      name: 'main',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const MainScreen(), transition: fadeSlideLR);
      },
    ),

    GoRoute(
      path: '/profile',
      name: 'profile',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const ProfileScreen(), transition: homeScreenWithOverlayResponse);
      },
    ),

    GoRoute(
      path: '/edit-profile',
      name: 'edit-profile',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const EditProfileScreen(), transition: homeScreenWithOverlayResponse);
      },
    ),

    GoRoute(
      path: '/terms',
      name: 'terms',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const TermsAndConditionsScreen(), transition: homeScreenWithOverlayResponse);
      },
    ),

    GoRoute(
      path: '/privacy',
      name: 'privacy',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const PrivacyPolicyScreen(), transition: homeScreenWithOverlayResponse);
      },
    ),

    GoRoute(
      path: '/all-categories',
      name: 'all-categories',
      pageBuilder: (context, state) {
        return buildPage(key: state.pageKey, child: const AllCategoriesScreen(), transition: homeScreenWithOverlayResponse);
      },
    ),
  ],
);
