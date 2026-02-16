import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/config/navigation/route_names.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/common_widgets/info_row_widget.dart';
import 'package:secure_branch_app/core/di/di.dart';
import 'package:secure_branch_app/features/authentication/logout/data/auth_logout_service.dart';
import 'package:secure_branch_app/features/home/presentation/widgets/home_widgets/index.dart';
import 'package:secure_branch_app/features/transactions/data/models/transactions_models.dart';
import 'package:secure_branch_app/features/transactions/presentation/blocs/transactions_bloc/transactions_bloc.dart';
import 'package:secure_branch_app/features/transactions/presentation/shimmers/transactions_shimmer_view.dart';
import 'package:secure_branch_app/features/transactions/presentation/widgets/sliver_transaction_list.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (BuildContext context, TransactionsState state) {
        final List<TransactionsModels> transactions =
            state.responseModel ?? <TransactionsModels>[];
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 220.h,
              pinned: true,
              stretch: true,
              backgroundColor: AppColors.primaryDark,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.logout, color: AppColors.primaryWhite),
                  onPressed: () async {
                    await di<AuthLogoutService>().logout();
                    if (context.mounted) {
                      context.go(RouteNames.login);
                    }
                  },
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
              flexibleSpace: const FlexibleSpaceBar(
                stretchModes: <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                background: BalanceWidget(),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InfoRowWidget(title: LocaleKeys.yourSecureCards.tr()),
                    SizedBox(height: 12.h),
                    const CreditCardWidget(),

                    SizedBox(height: 24.h),

                    const BranchesActionButton(),

                    SizedBox(height: 24.h),

                    InfoRowWidget(
                      title: LocaleKeys.recentActivity.tr(),
                      trailing: LocaleKeys.viewAll.tr(),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
            if (state.isLoaded && transactions.isEmpty)
              const SliverToBoxAdapter(child: SizedBox.shrink())
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: state.isLoading || state.isInitial
                    ? const TransactionsShimmerView()
                    : SliverTransactionList(transactions: transactions),
              ),

            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          ],
        );
      },
    );
  }
}
