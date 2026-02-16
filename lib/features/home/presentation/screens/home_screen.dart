import 'package:flutter/material.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/features/home/presentation/bottom_sheets/add_transaction_bottom_sheet.dart';
import 'package:secure_branch_app/features/home/presentation/widgets/home_widgets/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The FAB now feels like a "Add Transaction" trigger
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        elevation: 8,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
        onPressed: () => _showAddTransactionSheet(context),
      ),
      body: const HomeBody(),
    );
  }

  void _showAddTransactionSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => const AddTransactionBottomSheet(),
    );
  }
}
