import 'package:flutter/material.dart';
import 'package:secure_branch_app/features/branch/presentation/widgets/branch_widgets/index.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: BranchBody());
  }
}
