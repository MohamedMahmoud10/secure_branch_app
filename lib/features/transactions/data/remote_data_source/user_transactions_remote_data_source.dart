import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/core/utilities/constants/database_constants.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/features/transactions/data/models/transactions_models.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
@lazySingleton
class UserTransactionsRemoteDataSource {
  final FirebaseFirestore _client;
  final BaseDatabase _database;

  UserTransactionsRemoteDataSource(this._client, this._database);

  Stream<List<TransactionsModels>> getTransactions() {
    final UserDataModel? userData = _database.get<UserDataModel>(
      tableName: DatabaseConstants.userDataTable,
      key: DatabaseConstants.userDataKey,
    );

    final String? userDocumentId = userData?.documentId;

    if (userDocumentId == null) {
      return const Stream<List<TransactionsModels>>.empty();
    }

    return _client
        .collection(DatabaseConstants.usersDataCollection)
        .doc(userDocumentId)
        .collection(DatabaseConstants.userTransactionCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (QuerySnapshot<Map<String, dynamic>> snapshot) => snapshot.docs
              .map(
                (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                    TransactionsModels.fromJson(doc.data()),
              )
              .toList(),
        )
        .handleError((dynamic error) {
          AppLogger().error('Error From Get Transactions $error');
        });
  }
}
