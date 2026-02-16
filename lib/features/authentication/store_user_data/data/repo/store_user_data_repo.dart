import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/data_sources/local_data_source/save_user_data_local_data_source.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/data_sources/remote_data_source/store_user_data_remote_data_source.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class StoreUserDataRepo {
  final StoreUserDataRemoteDataSource _remoteDataSource;
  final SaveUserDataLocalDataSource _dataLocalDataSource;

  StoreUserDataRepo(this._remoteDataSource, this._dataLocalDataSource);

  Future<Result<void, FirebaseException>> storeUserData({
    required UserDataModel requestModel,
  }) async {
    try {
      final void result = await _remoteDataSource.storeUserData(
        requestModel: requestModel,
      );
      await _dataLocalDataSource.saveUserData(requestModel);

      return Success<void, FirebaseException>(result);
    } on FirebaseException catch (e) {
      AppLogger().error('Error From Store User Data Repo $e');
      return Error<void, FirebaseException>(e);
    }
  }
}
