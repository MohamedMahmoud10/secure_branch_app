import 'package:flutter/foundation.dart' show immutable;

@immutable
class RouteNames {
  const RouteNames._();

  /// Region Of App Routes
  static String get splash => '/splash';

  static String get home => '/';
  static String get branches => '/branches';

  static String get favorites => '/favorites';

  static String get register => '/register';
  static String get login => '/login';

  /// End Region Of App Routes
}
