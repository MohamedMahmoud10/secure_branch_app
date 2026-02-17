part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}
final class FirstTransactionsFetch extends TransactionsEvent{}
final class UpdateTransactions extends TransactionsEvent{
  final List<TransactionsModels>? responseModel;
  UpdateTransactions({required this.responseModel});
}
final class TransactionsError extends TransactionsEvent{
  final String errorMsg;
  TransactionsError({required this.errorMsg});
}
