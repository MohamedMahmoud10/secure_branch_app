import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/app_routes.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellHomeNavigatorStateKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final GlobalKey<NavigatorState> shellBranchesNavigatorStateKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellBranches');
final GlobalKey<NavigatorState> shellFavoritesNavigatorStateKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellFavorites');


final GoRouter router = GoRouter(
  initialLocation: RouteNames.splash,
  routes: appRoutes,
  navigatorKey: navigationKey,
  debugLogDiagnostics: true,
  routerNeglect: true,
  onException: (BuildContext context, GoRouterState state, GoRouter exception) {
    debugPrint('GoRouter exception: $exception at ${state.uri}');
  },
);
