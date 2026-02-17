import 'package:biometric_signature/biometric_signature.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

@lazySingleton
class BiometricAuthService {
  BiometricAuthService() : _biometricSignature = BiometricSignature();

  final BiometricSignature _biometricSignature;

  /// Returns `true` when the device has biometric hardware *and* the user
  /// has enrolled at least one biometric (fingerprint / face).
  Future<bool> isBiometricAvailable() async {
    try {
      final BiometricAvailability availability = await _biometricSignature
          .biometricAuthAvailable();
      final bool available =
          (availability.canAuthenticate ?? false) &&
          (availability.hasEnrolledBiometrics ?? false);
      AppLogger().info('BiometricAuthService.isBiometricAvailable: $available');
      return available;
    } catch (e, st) {
      AppLogger().error('BiometricAuthService.isBiometricAvailable: $e\n$st');
      return false;
    }
  }

  /// Checks the device's biometric capabilities and enrollment status.
  Future<BiometricStatus> getBiometricStatus() async {
    try {
      final BiometricAvailability availability = await _biometricSignature
          .biometricAuthAvailable();

      if (!(availability.canAuthenticate ?? false)) {
        return BiometricStatus.noHardware;
      }

      if (!(availability.hasEnrolledBiometrics ?? false)) {
        return BiometricStatus.notEnrolled;
      }
      return BiometricStatus.failure;
    } catch (e, st) {
      AppLogger().error('BiometricAuthService.getBiometricStatus: $e\n$st');
      return BiometricStatus.failure;
    }
  }

  Future<String?> createKeys() async {
    try {
      final KeyCreationResult result = await _biometricSignature.createKeys(
        promptMessage: LocaleKeys.registerBiometric.tr(),
        keyFormat: KeyFormat.pem,
        config: CreateKeysConfig(
          signatureType: SignatureType.ecdsa,
          enforceBiometric: true,
          setInvalidatedByBiometricEnrollment: true,
          enableDecryption: false,
        ),
      );

      if (result.code == BiometricError.success &&
          result.publicKey != null &&
          result.publicKey!.isNotEmpty) {
        AppLogger().info(
          'BiometricAuthService.createKeys: success '
          '(publicKey length=${result.publicKey!.length})',
        );
        return result.publicKey;
      }

      AppLogger().warning(
        'BiometricAuthService.createKeys: failed — '
        'code=${result.code}, error=${result.error}',
      );
      return null;
    } catch (e, st) {
      AppLogger().error('BiometricAuthService.createKeys: $e\n$st');
      return null;
    }
  }

  /// Deletes the previously generated key pair from hardware storage.
  Future<bool> deleteKeys() async {
    try {
      final bool deleted = await _biometricSignature.deleteKeys();
      AppLogger().info('BiometricAuthService.deleteKeys: $deleted');
      return deleted;
    } catch (e, st) {
      AppLogger().error('BiometricAuthService.deleteKeys: $e\n$st');
      return false;
    }
  }

  Future<bool> doesKeyExist() async {
    try {
      return _biometricSignature.biometricKeyExists(checkValidity: true);
    } catch (e, st) {
      AppLogger().error('BiometricAuthService.doesKeyExist: $e\n$st');
      return false;
    }
  }

  /// Sign data with biometric authentication
  Future<String?> createSignature({required String payload}) async {
    try {
      final SignatureResult result = await _biometricSignature.createSignature(
        payload: payload,
        promptMessage: LocaleKeys.authenticateToSignIn.tr(),
        keyFormat: KeyFormat.pem,
      );

      if (result.code == BiometricError.success &&
          result.signature != null &&
          result.signature!.isNotEmpty) {
        AppLogger().info(
          'BiometricAuthService.createSignature: success '
          '(signature length=${result.signature!.length})',
        );
        return result.signature;
      }

      AppLogger().warning(
        'BiometricAuthService.createSignature: failed — '
        'code=${result.code}, error=${result.error}',
      );
      return null;
    } catch (e, st) {
      AppLogger().error('BiometricAuthService.createSignature: $e\n$st');
      return null;
    }
  }
}
