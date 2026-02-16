import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/core/infrastructure/secure_storage/secure_storage_service.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/hive_registrar.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@LazySingleton(as: BaseDatabase)
class HiveDatabaseClient implements BaseDatabase {
  HiveDatabaseClient(this._secureStorage);

  final SecureStorageService _secureStorage;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();

    await _ensureEncryptedBoxOpen<BranchesResponseModel>(
      DatabaseConstants.branchesTable,
    );
    await _ensureEncryptedBoxOpen<BranchesResponseModel>(
      DatabaseConstants.favoritesTable,
    );
    await _ensureEncryptedBoxOpen<UserDataModel>(DatabaseConstants.userDataTable);

  }

  Future<void> _ensureEncryptedBoxOpen<T>(String tableName) async {
    if (Hive.isBoxOpen(tableName)) return;
    List<int>? key = await _secureStorage.readHiveEncryptionKey();
    if (key == null || key.length != 32) {
      AppLogger().info('Generate Key $key');
      key = Hive.generateSecureKey();
      await _secureStorage.writeHiveEncryptionKey(key);
    }
    AppLogger().info('No Need Generate Key Already Cached $key');

    await Hive.openBox<T>(tableName, encryptionCipher: HiveAesCipher(key));
  }

  /// Always opens the user box as [UserDataModel]. No type parameter needed.
  @override
  Future<void> ensureUserBoxOpen() =>
      _ensureEncryptedBoxOpen<UserDataModel>(DatabaseConstants.userDataTable);

  @override
  Future<void> save<T>({
    required String tableName,
    required String key,
    required T value,
  }) async {
    final Box<T> box = Hive.box<T>(tableName);
    return box.put(key, value);
  }

  @override
  Future<void> saveAll<T>({
    required String tableName,
    required List<T>? list,
    required List<dynamic>? keys,
  }) async {
    if (list != null && keys != null && list.length == keys.length) {
      final Box<T> box = Hive.box<T>(tableName);
      await box.putAll(Map<dynamic, T>.fromIterables(keys, list));
    }
  }

  @override
  T? get<T>({required String tableName, required String key}) {
    if (!Hive.isBoxOpen(tableName)) return null;
    return Hive.box<T>(tableName).get(key);
  }

  @override
  List<T>? getAll<T>({required String tableName}) {
    if (!Hive.isBoxOpen(tableName)) return null;
    return Hive.box<T>(tableName).values.toList();
  }

  @override
  Future<void> delete<T>({
    required String tableName,
    required String key,
  }) async {
    final Box<T> box = Hive.box<T>(tableName);
    return box.delete(key);
  }

  @override
  Future<int> clear<T>({required String tableName}) async {
    final Box<T> box = Hive.box<T>(tableName);
    return box.clear();
  }

  @override
  Future<int> add<T>({required String tableName, required T data}) async {
    final Box<T> box = Hive.box<T>(tableName);
    return box.add(data);
  }

  @override
  Future<void> update<T>({
    required String tableName,
    required String key,
    required T Function(T current) updateCallback,
  }) async {
    final Box<T> box = Hive.box<T>(tableName);
    final T? current = box.get(key);

    if (current != null) {
      final T updated = updateCallback(current);
      await box.put(key, updated);
    }
  }
}
