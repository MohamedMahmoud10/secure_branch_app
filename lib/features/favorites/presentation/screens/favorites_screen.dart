import 'package:flutter/material.dart';
import 'package:secure_branch_app/features/favorites/presentation/widgets/favorites_widgets/index.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: FavoritesBody());
  }
}
