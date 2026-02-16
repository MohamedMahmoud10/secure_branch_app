import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';
import 'package:secure_branch_app/core/di/index.dart';
import 'package:secure_branch_app/features/authentication/logout/data/auth_logout_service.dart';
import 'package:secure_branch_app/features/home/presentation/widgets/home_widgets/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await di<AuthLogoutService>().logout();
              if (context.mounted) {
                context.go(RouteNames.login);
              }
            },
          ),
        ],
      ),
      body: const HomeBody(),
    );
  }
}
