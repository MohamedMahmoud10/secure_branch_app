import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:secure_branch_app/app/secure_branch_app.dart';
import 'package:secure_branch_app/app_init.dart';
import 'package:secure_branch_app/generated/codegen_loader.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    await AppInit().beforeAppInit();

    runApp(
      EasyLocalization(
        supportedLocales: const <Locale>[Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: const SecureBranchApp(
        ),
      ),
    );
  }, (Object error, StackTrace stack) {
    AppLogger().error('Unhandled platform error: $error\n$stack');
  });
}
