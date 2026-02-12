import 'package:flutter/material.dart';
import 'package:gtr/core/widgets/text.dart';
import '../routing/app_router.dart';

class SnackBarDispatcher {
  static bool _isErrorShowing = false;
  static bool _isSuccessShowing = false;

  static void showError(String? error, {BuildContext? context, bool showFromTop = false}) {
    if (_isErrorShowing) return;

    final navigatorContext = context ?? rootNavigatorKey.currentContext;
    if (navigatorContext == null) return;

    _isErrorShowing = true;
    final scaffoldMessenger = ScaffoldMessenger.of(navigatorContext);
    final mediaQuery = MediaQuery.of(navigatorContext);

    scaffoldMessenger
        .showSnackBar(
          SnackBar(
            content: CustomText(text: error ?? "حدث خطأ غير معروف", color: Colors.white, fontWeight: FontWeight.bold),
            backgroundColor: Theme.of(navigatorContext).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            margin: showFromTop ? EdgeInsets.only(top: mediaQuery.padding.top + 16, left: 16, right: 16) : const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            duration: const Duration(seconds: 3),
          ),
        )
        .closed
        .then((_) => _isErrorShowing = false);
  }

  static void showMessage(String message, {BuildContext? context, bool showFromTop = false}) {
    if (_isSuccessShowing) return;

    final navigatorContext = context ?? rootNavigatorKey.currentContext;
    if (navigatorContext == null) return;

    _isSuccessShowing = true;
    ScaffoldMessenger.of(navigatorContext)
        .showSnackBar(
          SnackBar(
            content: CustomText(text: message, color: Colors.white, fontWeight: FontWeight.bold),
            backgroundColor: Theme.of(navigatorContext).colorScheme.tertiary,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        )
        .closed
        .then((_) => _isSuccessShowing = false);
  }
}
