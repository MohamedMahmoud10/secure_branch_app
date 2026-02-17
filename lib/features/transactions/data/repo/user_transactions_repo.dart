import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/features/transactions/data/models/transactions_models.dart';
import 'package:secure_branch_app/features/transactions/data/remote_data_source/user_transactions_remote_data_source.dart';

@lazySingleton
class UserTransactionsRepo {
  final UserTransactionsRemoteDataSource _remoteDataSource;

  UserTransactionsRepo(this._remoteDataSource);

  Stream<List<TransactionsModels>> getTransactions() {
    return _remoteDataSource.getTransactions();
  }
}
