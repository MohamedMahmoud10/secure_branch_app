import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/core/infrastructure/secure_storage/secure_storage_service.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';

@lazySingleton
class AuthLogoutService {
  AuthLogoutService(
    this._auth,
    this._db,
    this._secureStorage,
  );

  final FirebaseAuth _auth;
  final BaseDatabase _db;
  final SecureStorageService _secureStorage;

  /// Signs out from Firebase, clears local user data, closes the user box,
  /// and removes the encryption key from secure storage.
  Future<void> logout() async {
    await _auth.signOut();
    await _db.ensureUserBoxOpen();
    await _db.delete<UserDataModel>(
      tableName: DatabaseConstants.userDataTable,
      key: DatabaseConstants.userDataKey,
    );
    await _db.closeUserBox();
    await _secureStorage.deleteHiveEncryptionKey();
  }
}
