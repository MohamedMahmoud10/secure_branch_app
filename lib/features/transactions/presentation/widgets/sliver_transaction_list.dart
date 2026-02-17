import 'package:flutter/material.dart';
import 'package:secure_branch_app/features/transactions/data/models/transactions_models.dart';
import 'package:secure_branch_app/features/transactions/presentation/widgets/transaction_view.dart';

class SliverTransactionList extends StatelessWidget {
  const SliverTransactionList({required this.transactions, super.key});

  final List<TransactionsModels> transactions;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final TransactionsModels item = transactions[index];
        return TransactionView(transactionsModels: item);
      }, childCount: transactions.length),
    );
  }
}
