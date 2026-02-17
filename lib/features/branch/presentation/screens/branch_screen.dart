import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_branch_app/features/branch/presentation/cubits/branches_cubit/branches_cubit.dart';
import 'package:secure_branch_app/features/branch/presentation/widgets/branch_widgets/index.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen({super.key});

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  late Cubit<BranchesState> _branchesCubit;

  @override
  void initState() {
    _branchesCubit = BlocProvider.of<BranchesCubit>(context);
    if (_branchesCubit.state.isInitial) {
      _branchesCubit = BlocProvider.of<BranchesCubit>(context)..getBranches();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: BranchBody());
  }
}
