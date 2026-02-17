import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Keys for secure storage. Use these so we can clear auth-related data on logout.
abstract class SecureStorageKeys {
  const SecureStorageKeys._();

  static const String hiveEncryptionKey = 'hive_encryption_key';
}

@lazySingleton
class SecureStorageService {
  SecureStorageService() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Reads the Hive encryption key (base64). Returns null if not set.
  Future<List<int>?> readHiveEncryptionKey() async {
    final String? encoded = await read(SecureStorageKeys.hiveEncryptionKey);
    if (encoded == null) return null;
    return base64Url.decode(encoded);
  }

  /// Writes the Hive encryption key (must be 32 bytes). Overwrites if exists.
  Future<void> writeHiveEncryptionKey(List<int> key) async {
    await write(SecureStorageKeys.hiveEncryptionKey, base64Url.encode(key));
  }

  /// Removes the Hive encryption key (e.g. on logout).
  Future<void> deleteHiveEncryptionKey() async {
    await delete(SecureStorageKeys.hiveEncryptionKey);
  }
}
