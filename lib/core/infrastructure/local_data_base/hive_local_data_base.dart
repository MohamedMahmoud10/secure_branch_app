import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/core/infrastructure/secure_storage/secure_storage_service.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/authentication/store_user_data/data/models/user_data_model.dart';
import 'package:secure_branch_app/hive_registrar.g.dart';

@LazySingleton(as: BaseDatabase)
class HiveDatabaseClient implements BaseDatabase {
  HiveDatabaseClient(this._secureStorage);

  final SecureStorageService _secureStorage;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
    // User box is opened lazily with encryption in ensureUserBoxOpen().
  }

  Future<void> _ensureUserBoxOpen() async {
    if (Hive.isBoxOpen(DatabaseConstants.userDataTable)) return;
    List<int>? key = await _secureStorage.readHiveEncryptionKey();
    if (key == null || key.length != 32) {
      key = Hive.generateSecureKey();
      await _secureStorage.writeHiveEncryptionKey(key);
    }
    await Hive.openBox<UserDataModel>(
      DatabaseConstants.userDataTable,
      encryptionCipher: HiveAesCipher(key),
    );
  }

  @override
  Future<void> ensureUserBoxOpen() => _ensureUserBoxOpen();

  @override
  Future<void> closeUserBox() async {
    if (Hive.isBoxOpen(DatabaseConstants.userDataTable)) {
      await Hive.box<UserDataModel>(DatabaseConstants.userDataTable).close();
    }
  }

  @override
  Future<void> save<T>({
    required String tableName,
    required String key,
    required T value,
  }) async {
    if (tableName == DatabaseConstants.userDataTable) {
      await _ensureUserBoxOpen();
    } else if (!Hive.isBoxOpen(tableName)) {
      await Hive.openBox<T>(tableName);
    }
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
      for (int i = 0; i < list.length; i++) {
        await box.put(keys[i], list[i]);
      }
    }
  }

  @override
  T? get<T>({required String tableName, required String key}) {
    final Box<T> box = Hive.box<T>(tableName);
    return box.get(key);
  }

  @override
  List<T>? getAll<T>({required String tableName}) {
    final Box<T> box = Hive.box<T>(tableName);
    return box.values.toList();
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
  Future<int> clear({required String tableName}) async {
    final Box<dynamic> box = Hive.box(tableName);
    return box.clear();
  }

  @override
  Future<int> add<T>({required String tableName, required T data}) {
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
