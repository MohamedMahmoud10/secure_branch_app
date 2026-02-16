import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/infrastructure/secure_storage/secure_storage_service.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

/// Handles AES-256-CBC encryption / decryption of the user password and
@lazySingleton
class BiometricCryptoService {
  BiometricCryptoService(this._secureStorage);

  final SecureStorageService _secureStorage;

  /// Encrypts [password] with a fresh AES-256 key and stores everything
  Future<void> storeCredentials({
    required String email,
    required String password,
  }) async {
    try {
      /// Generate a random AES-256 key (32 bytes) and IV (16 bytes).
      final List<int> rawKey = _secureRandom(32);
      final List<int> rawIv = _secureRandom(16);

      final enc.Key key = enc.Key.fromBase64(base64Url.encode(rawKey));
      final enc.IV iv = enc.IV.fromBase64(base64Url.encode(rawIv));

      final enc.Encrypter encrypter = enc.Encrypter(enc.AES(key));

      final String encrypted = encrypter.encrypt(password, iv: iv).base64;

      await Future.wait(<Future<void>>[
        _secureStorage.write(
          DatabaseConstants.aesKeyStorageKey,
          base64Url.encode(rawKey),
        ),
        _secureStorage.write(
          DatabaseConstants.aesIvStorageKey,
          base64Url.encode(rawIv),
        ),
        _secureStorage.write(DatabaseConstants.encryptedPasswordKey, encrypted),
        _secureStorage.write(DatabaseConstants.biometricEmailKey, email),
        _secureStorage.write(DatabaseConstants.biometricEnrolledKey, 'true'),
      ]);

      AppLogger().info(
        'BiometricCryptoService.storeCredentials: '
        'credentials encrypted & stored for $email',
      );
    } catch (e, st) {
      AppLogger().error('BiometricCryptoService.storeCredentials: $e\n$st');
      rethrow;
    }
  }

  /// Decrypts and returns the stored password.  Returns `null` when no
  Future<String?> retrievePassword() async {
    try {
      final String? encodedKey = await _secureStorage.read(DatabaseConstants.aesKeyStorageKey);
      final String? encodedIv = await _secureStorage.read(DatabaseConstants.aesIvStorageKey);
      final String? encrypted = await _secureStorage.read(
        DatabaseConstants.encryptedPasswordKey,
      );

      if (encodedKey == null || encodedIv == null || encrypted == null) {
        AppLogger().warning(
          'BiometricCryptoService.retrievePassword: no stored credentials',
        );
        return null;
      }

      final enc.Key key = enc.Key.fromBase64(encodedKey);
      final enc.IV iv = enc.IV.fromBase64(encodedIv);

      final enc.Encrypter encrypter = enc.Encrypter(enc.AES(key));

      final String decrypted = encrypter.decrypt64(encrypted, iv: iv);
      AppLogger().info(
        'BiometricCryptoService.retrievePassword: decryption successful',
      );
      return decrypted;
    } catch (e, st) {
      AppLogger().error('BiometricCryptoService.retrievePassword: $e\n$st');
      return null;
    }
  }

  Future<String?> retrieveEmail() async {
    return _secureStorage.read(DatabaseConstants.biometricEmailKey);
  }

  Future<bool> isBiometricEnrolled() async {
    final String? value = await _secureStorage.read(DatabaseConstants.biometricEnrolledKey);
    return value == 'true';
  }


  /// Cryptographically secure random bytes.
  List<int> _secureRandom(int length) {
    final Random random = Random.secure();
    return List<int>.generate(length, (_) => random.nextInt(256));
  }
}
