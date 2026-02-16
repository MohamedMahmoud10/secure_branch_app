import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/app_router.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';
import 'package:secure_branch_app/core/helpers/app_helper_functions.dart';
import 'package:secure_branch_app/features/authentication/login/presentation/screens/login_screen.dart';
import 'package:secure_branch_app/features/authentication/register/presentation/screens/register_screen.dart';
import 'package:secure_branch_app/features/branch/presentation/screens/branch_screen.dart';
import 'package:secure_branch_app/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:secure_branch_app/features/home/presentation/screens/home_screen.dart';
import 'package:secure_branch_app/features/main_navigation/screens/secure_branch_main_navigation_screen.dart';
import 'package:secure_branch_app/features/splash/presentation/screens/splash_screen.dart';

final List<RouteBase> appRoutes = <RouteBase>[
  StatefulShellRoute(
    navigatorContainerBuilder:
        (
          BuildContext context,
          StatefulNavigationShell navigationShell,
          List<Widget> children,
        ) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: children[navigationShell.currentIndex],
          );
        },
    builder: (_, __, StatefulNavigationShell navigationShell) {
      return SecureBranchMainNavigationScreen(
        navigationShell: navigationShell,
        hideChatScreen: true,
      );
    },

    ///SplashScreen
    branches: <StatefulShellBranch>[
      StatefulShellBranch(
        navigatorKey: shellHomeNavigatorStateKey,
        routes: <GoRoute>[
          GoRoute(
            path: RouteNames.home,
            parentNavigatorKey: shellHomeNavigatorStateKey,
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: shellBranchesNavigatorStateKey,
        routes: <GoRoute>[
          GoRoute(
            path: RouteNames.branches,
            parentNavigatorKey: shellBranchesNavigatorStateKey,
            builder: (BuildContext context, GoRouterState state) {
              return const BranchScreen();
            },
          ),
        ],
      ),
      StatefulShellBranch(
        navigatorKey: shellFavoritesNavigatorStateKey,
        routes: <GoRoute>[
          GoRoute(
            path: RouteNames.favorites,
            parentNavigatorKey: shellFavoritesNavigatorStateKey,
            builder: (BuildContext context, GoRouterState state) {
              return const FavoritesScreen();
            },
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: RouteNames.splash,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return AppHelperFunctions().fadeTransition(page: const SplashScreen());
    },
  ),

  GoRoute(
    path: RouteNames.register,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return AppHelperFunctions().slideFromBottomToTopTransition(
        page: const RegisterScreen(),
      );
    },
  ),
  GoRoute(
    path: RouteNames.login,
    pageBuilder: (BuildContext context, GoRouterState state) {
      return AppHelperFunctions().fadeTransition(page: const LoginScreen());
    },
  ),
];
