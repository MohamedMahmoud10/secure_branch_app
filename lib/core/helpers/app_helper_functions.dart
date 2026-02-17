import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/app_router.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';

// ignore: depend_on_referenced_packages
import 'package:secure_branch_app/core/di/index.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

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

  /// Validates auth and cached user data, then navigates appropriately.
  ///
  /// Uses Firebase [currentUser] as source of truth. If no Firebase user,
  /// always go to login. If Firebase user exists, check local cache for user
  /// data and go to home or login accordingly.
  Future<void> checkCachedKeysAndNavigate() async {
    try {
      final User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) {
        AppLogger().info('No Firebase user. Redirecting to login.');
        router.go(RouteNames.login);
        return;
      }

      final UserDataModel? userData = dbClient.get<UserDataModel>(
        tableName: DatabaseConstants.userDataTable,
        key: DatabaseConstants.userDataKey,
      );
      AppLogger().info('The Cached User Data Is $userData');

      if (userData == null) {
        AppLogger().error(
          'No user data found in cache. Redirecting to authentication.',
        );
        router.go(RouteNames.login);
        return;
      }

      router.go(RouteNames.home);
    } catch (e, stackTrace) {
      AppLogger().error('Error while checking cached keys: $e\n$stackTrace');
      router.go(RouteNames.login);
    }
  }

  /// Opens the native maps application for turn-by-turn navigation
  /// to the provided latitude and longitude.
  ///
  /// This method attempts to launch Google Maps first (using the
  /// `google.navigation` scheme). If Google Maps is not available,
  /// it falls back to Apple Maps.
  ///
  /// Parameters:
  /// - [lat]: Destination latitude. If `null`, the method returns early.
  /// - [lng]: Destination longitude. If `null`, the method returns early.
  ///
  /// Behavior:
  /// - Launches Google Maps if supported on the device.
  /// - Otherwise, launches Apple Maps if available.
  /// - If neither maps application can be launched, an exception is thrown.
  ///
  /// Throws:
  /// - A [String] error if no compatible maps application is found.

  Future<void> openMap(double? lat, double? lng) async {
    if (lat == null || lng == null) return;
    final Uri googleMapsUrl = Uri.parse('google.navigation:q=$lat,$lng');
    final Uri appleMapsUrl = Uri.parse('https://maps.apple.com/?q=$lat,$lng');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    } else {
      throw Exception(LocaleKeys.couldNotLaunchMaps.tr());
    }
  }
}
