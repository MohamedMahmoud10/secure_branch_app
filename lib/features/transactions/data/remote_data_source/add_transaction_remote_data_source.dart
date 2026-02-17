import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/core/utilities/constants/database_constants.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/features/transactions/data/models/transactions_models.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class AddTransactionRemoteDataSource {
  final FirebaseFirestore _client;
  final BaseDatabase _database;

  AddTransactionRemoteDataSource(this._client, this._database);

  Future<void> addTransaction({
    required TransactionsModels requestModel,
  }) async {
    try {
      final UserDataModel? userData = _database.get<UserDataModel>(
        tableName: DatabaseConstants.userDataTable,
        key: DatabaseConstants.userDataKey,
      );

      final String? userDocumentId = userData?.documentId;

      final DocumentReference<Map<String, dynamic>> databaseCollection = _client
          .collection(DatabaseConstants.usersDataCollection)
          .doc(userDocumentId)
          .collection(DatabaseConstants.userTransactionCollection)
          .doc();

      final String transactionsDocumentId = databaseCollection.id;
      if (userDocumentId != null) {
        await databaseCollection.set(
          requestModel
              .copyWith(
                documentId: transactionsDocumentId,
                createdAt: DateTime.now(),
              )
              .toJson(),
        );
      }
    } on FirebaseException catch (e) {
      AppLogger().error('Error From Add Transaction $e');
      rethrow;
    }
  }
}
