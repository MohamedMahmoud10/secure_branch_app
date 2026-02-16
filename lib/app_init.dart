import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/core/di/index.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/firebase_options.dart';
import 'package:secure_branch_app/utils/bloc_observer.dart';

class AppInit {
  static final AppInit _instance = AppInit._internal();

  factory AppInit() => _instance;

  AppInit._internal();

  Future<void> beforeAppInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Upgrader.clearSavedSettings();
    await dotenv.load();

    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    configureDependencies();

    await EasyLocalization.ensureInitialized();

    await ScreenUtil.ensureScreenSize();

    await di<BaseDatabase>().init();
    await di<BaseDatabase>().ensureUserBoxOpen();

    Bloc.observer = AppBlocObserver();
  }
}
