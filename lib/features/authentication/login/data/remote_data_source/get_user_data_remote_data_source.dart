import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class GetUserDataRemoteDataSource {
  final FirebaseFirestore _client;

  GetUserDataRemoteDataSource(this._client);

  Future<UserDataModel> getUserData(String userId) async {
    AppLogger().info('Fetching user data for userId: $userId');
    try {
      final CollectionReference<Map<String, dynamic>> dataBase =
          _client.collection(DatabaseConstants.usersDataCollection);

      final QuerySnapshot<Map<String, dynamic>> data =
          await dataBase.where('uId', isEqualTo: userId).get();

      if (data.docs.isEmpty) {
        AppLogger().error('No user data found for userId: $userId');
        throw Exception('No user data found for userId: $userId');
      }

      final Map<String, dynamic> userData = data.docs.first.data();

      return UserDataModel.fromJson(
        userData,
      );
    } catch (e, stackTrace) {
      AppLogger().error('Error retrieving user data: $e\n$stackTrace');
      rethrow;
    }
  }
}
