import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/features/home/presentation/widgets/home_widgets/index.dart';
import 'package:secure_branch_app/features/transactions/presentation/blocs/add_transaction_cubit/add_transaction_cubit.dart';
import 'package:secure_branch_app/features/transactions/presentation/blocs/transactions_bloc/transactions_bloc.dart';
import 'package:secure_branch_app/features/transactions/presentation/bottom_sheets/add_transaction_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Bloc<TransactionsEvent, TransactionsState> _transactionsBloc;

  @override
  void initState() {
    _transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    if (_transactionsBloc.state.isInitial) {
      _transactionsBloc = BlocProvider.of<TransactionsBloc>(context)
        ..add(FirstTransactionsFetch());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        elevation: 8,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BlocProvider<AddTransactionCubit>.value(
            value: BlocProvider.of<AddTransactionCubit>(context),
            child: const AddTransactionBottomSheet(),
          ),
        ),
      ),
      body: const HomeBody(),
    );
  }
}
