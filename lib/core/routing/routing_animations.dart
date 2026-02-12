import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget fadeSlideRL(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic)),
      child: child,
    ),
  );
}

Widget fadeSlideLR(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic)),
      child: child,
    ),
  );
}

Widget fadeSlideBT(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut, reverseCurve: Curves.easeIn)),
      child: child,
    ),
  );
}

/// Home screen transition with layering effect and surface color background
/// No black bars - uses theme surface color to fill any gaps
Widget homeScreenWithOverlayResponse(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final curve = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);

  final secondaryCurve = CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);

  // Incoming animation (when navigating TO home) - CHANGED TO BOTTOM TO TOP
  final incomingSlide = Tween<Offset>(
    begin: const Offset(0, 1), // Changed from (-1, 0) to (0, 1) for bottom to top
    end: Offset.zero,
  ).animate(curve);

  // Background animations (when home is being covered)
  final backgroundScale = Tween<double>(
    begin: 1.0,
    end: 0.94, // Scale to 94%
  ).animate(secondaryCurve);

  final backgroundSlide = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 0.05), // Slide down 5%
  ).animate(secondaryCurve);

  final backgroundOpacity = Tween<double>(
    begin: 1.0,
    end: 0.6, // Fade to create depth
  ).animate(secondaryCurve);

  return AnimatedBuilder(
    animation: Listenable.merge([animation, secondaryAnimation]),
    builder: (context, _) {
      Widget result = child;

      // Apply incoming animation when navigating TO this screen
      if (animation.status != AnimationStatus.dismissed) {
        result = SlideTransition(
          position: incomingSlide,
          child: FadeTransition(opacity: curve, child: result),
        );
      }

      // Apply background animation when being covered by another screen
      if (secondaryAnimation.status != AnimationStatus.dismissed) {
        // Wrap in a Container with surface color background to eliminate black bars
        result = Container(
          color: Theme.of(context).colorScheme.surface,
          child: SlideTransition(
            position: backgroundSlide,
            child: Transform.scale(
              scale: backgroundScale.value,
              alignment: Alignment.topCenter,
              child: Opacity(opacity: backgroundOpacity.value, child: result),
            ),
          ),
        );
      }

      return result;
    },
  );
}

/// Overlay screen that slides up from bottom
Widget overlayScreenSlideBT(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  final curve = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);

  final slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(curve);

  final scaleAnimation = Tween<double>(begin: 0.96, end: 1.0).animate(curve);

  return SlideTransition(
    position: slideAnimation,
    child: ScaleTransition(
      scale: scaleAnimation,
      alignment: Alignment.bottomCenter,
      child: FadeTransition(opacity: curve, child: child),
    ),
  );
}

CustomTransitionPage buildPage({
  required Widget child,
  required LocalKey key,
  required Widget Function(BuildContext, Animation<double>, Animation<double>, Widget) transition,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: transition,
  );
}
