import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

/// Provides a stable device identifier for this app install.
/// Used e.g. to associate biometric enrollment with a device in Firestore.
@lazySingleton
class DeviceIdService {
  DeviceIdService() : _deviceInfo = DeviceInfoPlugin();

  final DeviceInfoPlugin _deviceInfo;

  Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo info = await _deviceInfo.androidInfo;
        return info.fingerprint;
      }
      if (Platform.isIOS) {
        final IosDeviceInfo info = await _deviceInfo.iosInfo;
        return info.identifierForVendor ?? 'ios-unknown';
      }
    } catch (e, st) {
      AppLogger().error('DeviceIdService.getDeviceId: $e\n$st');
    }
    return 'unknown';
  }
}
