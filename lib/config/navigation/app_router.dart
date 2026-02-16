import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/app_routes.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';
import 'package:secure_branch_app/core/services/auth_state_notifier.dart';
import 'package:secure_branch_app/core/di/index.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellHomeNavigatorStateKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> shellBranchesNavigatorStateKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellBranches');
final GlobalKey<NavigatorState> shellFavoritesNavigatorStateKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellFavorites');

final AuthStateNotifier _authNotifier = AuthStateNotifier(di<FirebaseAuth>());

final GoRouter router = GoRouter(
  initialLocation: RouteNames.splash,
  routes: appRoutes,
  navigatorKey: navigationKey,
  refreshListenable: _authNotifier,
  redirect: (BuildContext context, GoRouterState state) {
    final String path = state.uri.path;
    if (path == RouteNames.splash||path == RouteNames.login || path == RouteNames.register) return null;
    final User? user = _authNotifier.currentUser;
    AppLogger().info('User Data From Firebase Is $user');
    if (user == null) {
      return RouteNames.login;
    }
    if (path == RouteNames.login || path == RouteNames.register) {
      return RouteNames.home;
    }
    return null;
  },
  debugLogDiagnostics: true,
  routerNeglect: true,
  onException: (BuildContext context, GoRouterState state, GoRouter exception) {
    AppLogger().error('GoRouter exception: $exception at ${state.uri}');
  },
);
