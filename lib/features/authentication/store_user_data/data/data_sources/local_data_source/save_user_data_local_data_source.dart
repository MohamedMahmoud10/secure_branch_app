import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';

@lazySingleton
class SaveUserDataLocalDataSource {
  final BaseDatabase _baseDatabase;

  SaveUserDataLocalDataSource(this._baseDatabase);

  Future<void> saveUserData(UserDataModel userDataModel) async {
    await _baseDatabase.save<UserDataModel>(
      tableName: DatabaseConstants.userDataTable,
      key: DatabaseConstants.userDataKey,
      value: userDataModel,
    );
  }
}
