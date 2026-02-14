
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:secure_branch_app/config/navigation/app_router.dart';
import 'package:secure_branch_app/config/theme/app_theme.dart';
import 'package:secure_branch_app/config/theme/app_theme_data.dart';
import 'package:secure_branch_app/core/const/const_strings.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class SecureBranchApp extends StatefulWidget {
  const SecureBranchApp({super.key});

  @override
  State<SecureBranchApp> createState() => _SecureBranchAppState();
}

class _SecureBranchAppState extends State<SecureBranchApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);


    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, Widget? child) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            title: AppStrings.applicationName,
            theme: AppTheme.light.themeData(),
            darkTheme: AppTheme.dark.darkThemeData(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            builder: (BuildContext context, Widget? child) {
              return RefreshConfiguration(
                headerBuilder: () {
                  return ClassicHeader(
                    idleText: LocaleKeys.pullToRefreshIdleText.tr(),
                    releaseText: LocaleKeys.pullToRefreshReleaseText.tr(),
                    refreshingText: LocaleKeys.pullToRefreshRefreshingText
                        .tr(),
                    completeText: LocaleKeys.pullToRefreshCompleteText.tr(),
                    failedText: LocaleKeys.pullToRefreshFailedText.tr(),
                  );
                },
                child: child!,
              );
            },
          ),

    );
  }
}
