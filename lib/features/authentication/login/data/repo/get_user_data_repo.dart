import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/features/authentication/login/data/remote_data_source/get_user_data_remote_data_source.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/data_sources/local_data_source/save_user_data_local_data_source.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class GetUserDataRepo {
  final GetUserDataRemoteDataSource _remoteDataSource;
  final SaveUserDataLocalDataSource _dataLocalDataSource;

  GetUserDataRepo(this._remoteDataSource, this._dataLocalDataSource);

  Future<Result<UserDataModel, FirebaseException>> getUserData(
    String userId,
  ) async {
    try {
      final UserDataModel result = await _remoteDataSource.getUserData(userId);
      await _dataLocalDataSource.saveUserData(result);
      return Success<UserDataModel, FirebaseException>(result);
    } on FirebaseException catch (e) {
      AppLogger().error('Error From Get User Data Repo $e');
      return Error<UserDataModel, FirebaseException>(e);
    }
  }
}
