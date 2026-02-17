import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/features/transactions/data/models/transactions_models.dart';
import 'package:secure_branch_app/features/transactions/data/remote_data_source/add_transaction_remote_data_source.dart';

@lazySingleton
class AddTransactionRepo {
  final AddTransactionRemoteDataSource _remoteDataSource;

  AddTransactionRepo(this._remoteDataSource);

  Future<Result<void, FirebaseException>> addTransaction({
    required TransactionsModels requestModel,
  }) async {
    try {
      final  void response = await _remoteDataSource.addTransaction(
        requestModel: requestModel,
      );
      return Success<void, FirebaseException>(response);
    } on FirebaseException catch (e) {
      return Error<void, FirebaseException>(e);
    }
  }
}
