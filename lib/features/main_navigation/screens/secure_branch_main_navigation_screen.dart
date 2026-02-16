import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/config/theme/app_system_ui_overlay_styles.dart';
import 'package:secure_branch_app/core/assets/app_icons.dart';
import 'package:secure_branch_app/core/di/index.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/core/services/biometric_auth_service.dart';
import 'package:secure_branch_app/features/branch/data/repo/branches_repo.dart';
import 'package:secure_branch_app/features/branch/presentation/cubits/branches_cubit/branches_cubit.dart';
import 'package:secure_branch_app/features/main_navigation/widgets/navigation_bar_icons.dart';
import 'package:secure_branch_app/features/transactions/data/repo/add_transaction_repo.dart';
import 'package:secure_branch_app/features/transactions/data/repo/user_transactions_repo.dart';
import 'package:secure_branch_app/features/transactions/presentation/blocs/add_transaction_cubit/add_transaction_cubit.dart';
import 'package:secure_branch_app/features/transactions/presentation/blocs/transactions_bloc/transactions_bloc.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class SecureBranchMainNavigationScreen extends StatefulWidget {
  const SecureBranchMainNavigationScreen({
    required this.navigationShell,
    super.key,
    this.hideChatScreen = false,
  });

  final StatefulNavigationShell navigationShell;
  final bool? hideChatScreen;

  @override
  State<SecureBranchMainNavigationScreen> createState() =>
      _SecureBranchMainNavigationScreenState();
}

class _SecureBranchMainNavigationScreenState
    extends State<SecureBranchMainNavigationScreen> {
  @override
  void initState() {
    super.initState();

    _initLocationAndBranches();
  }

  Future<void> _initLocationAndBranches() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    final int currentIndex = widget.navigationShell.currentIndex;
    void goBranch(int index) {
      widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUiOverlayStyles.darkStatusBarIconsStyle.copyWith(
        statusBarColor: AppColors.transparent,
        systemNavigationBarColor: Theme.of(
          context,
        ).colorScheme.secondaryContainer,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<BranchesCubit>(
            create: (BuildContext context) => BranchesCubit(di<BranchesRepo>()),
          ),
          BlocProvider<AddTransactionCubit>(
            create: (BuildContext context) => AddTransactionCubit(
              di<AddTransactionRepo>(),
              di<BiometricAuthService>(),
            ),
          ),
          BlocProvider<TransactionsBloc>(
            create: (BuildContext context) =>
                TransactionsBloc(di<UserTransactionsRepo>()),
          ),
        ],
        child: Scaffold(
          body: widget.navigationShell,
          bottomNavigationBar: Container(
            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
            height: 72.h,
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.primary.withValueOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                NavBarIcon(
                  icon: AppIcons.dashboardIcon,
                  label: LocaleKeys.home.tr(),
                  active: currentIndex == 0,
                  onClick: () => goBranch(0),
                ),
                NavBarIcon(
                  icon: AppIcons.mapIcon,
                  label: LocaleKeys.locator.tr(),
                  active: currentIndex == 1,
                  onClick: () => goBranch(1),
                ),
                NavBarIcon(
                  icon: AppIcons.shieldIcon,
                  label: LocaleKeys.vault.tr(),
                  active: currentIndex == 2,
                  onClick: () => goBranch(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
