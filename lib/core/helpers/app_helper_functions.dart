
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: depend_on_referenced_packages
import 'package:secure_branch_app/core/di/index.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';

/// A utility class that provides helper functions for common tasks
/// such as routing, transitions, and checking user states from local storage.
class AppHelperFunctions {
  // Singleton Instance of AppHelperFunctions
  static final AppHelperFunctions _instance = AppHelperFunctions._internal();

  // Factory constructor to provide the singleton instance
  factory AppHelperFunctions() => _instance;

  // Private constructor to initialize singleton instance
  AppHelperFunctions._internal();

  /// Creates a slide transition from bottom to top for a given page,
  /// compatible with GoRouter's CustomTransitionPage.
  Page<dynamic> slideFromBottomToTopTransition({required Widget page}) {
    return CustomTransitionPage<dynamic>(
      child: page,
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const Offset begin = Offset(0, 1);
            const Offset end = Offset.zero;
            const Cubic curve = Curves.easeOutQuint;

            final Animatable<Offset> tween = Tween<Offset>(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            final Animation<Offset> offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
    );
  }

  /// Creates a fade transition for a given page.
  ///
  /// This method wraps a page with a fade-in effect. You can use this
  /// transition to smoothly fade in a page, making it appear with a soft transition.
  Page<dynamic> fadeTransition({required Widget page}) {
    return CustomTransitionPage<dynamic>(
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            final Animation<double> slowedAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0, 1),
            );
            return FadeTransition(opacity: slowedAnimation, child: child);
          },
      child: page,
    );
  }

  /// Creates a slide transition from right to left for a given page.
  ///
  /// This method wraps a page with a transition where the page slides
  /// in from the right side of the screen. It's useful for navigation
  /// between pages where the incoming page comes in from the right.
  Page<dynamic> slideFromRightTransition({
    required Widget page,
    Duration duration = const Duration(milliseconds: 800),
  }) {
    return CustomTransitionPage<dynamic>(
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const Offset begin = Offset(1, 0); // Slide in from right
            const Offset end = Offset.zero; // End at the original position
            const Cubic curve = Curves.easeOutQuint; // Easing curve
            final Animatable<Offset> tween = Tween<Offset>(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
      transitionDuration: duration,
      child: page,
    );
  }

  /// Creates a slide transition from top to bottom for a given page.
  ///
  /// This method wraps a page with a transition where the page slides
  /// in from the top of the screen to the bottom. It's typically used
  /// for pages that slide down onto the screen.
  Page<dynamic> slideFromTopToBottomTransition({
    required Widget page,
    Duration duration = const Duration(milliseconds: 800),
  }) {
    return CustomTransitionPage<dynamic>(
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const Offset begin = Offset(0, -1); // Slide in from top
            const Offset end = Offset.zero; // End at the original position
            const Cubic curve = Curves.easeOutQuint; // Easing curve
            final Animatable<Offset> tween = Tween<Offset>(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
      transitionDuration: duration,
      child: page,
    );
  }

  // Database client used for accessing local storage
  final BaseDatabase dbClient = di<BaseDatabase>();

  /// This method uses the Flutter [FocusManager] to remove the current focus
  /// from any widget that is receiving user input, effectively dismissing
  /// the on-screen keyboard.
  ///
  /// Usage:
  /// ```dart
  /// hideKeyboard();
  /// ```
  ///
  /// Typical use cases include:
  /// - Dismissing the keyboard when tapping outside of a text field.
  /// - Closing the keyboard after form submission.
  ///
  /// Notes:
  /// - If no widget has focus or the keyboard is not visible, calling this
  ///   method will have no effect.
  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

}
