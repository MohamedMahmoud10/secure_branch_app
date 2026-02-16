import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/common_widgets/animated_circular_progress_indicator.dart';
import 'package:secure_branch_app/core/common_widgets/empty_state.dart';
import 'package:secure_branch_app/core/common_widgets/error_state.dart';
import 'package:secure_branch_app/features/branch/presentation/widgets/branch_widgets/index.dart';
import 'package:secure_branch_app/features/favorites/presentation/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:secure_branch_app/features/favorites/presentation/widgets/favorites_widgets/index.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (BuildContext context, FavoritesState state) {
        return RefreshIndicator(
          color: AppColors.accent,
          onRefresh: () => context.read<FavoritesCubit>().loadFavorites(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 160.h,
                pinned: true,
                stretch: true,
                backgroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30.r),
                  ),
                ),
                flexibleSpace: const FavoriteAppBar(),
              ),

              if (state.isLoading && state.favorites.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: AnimatedCircularProgressIndicator()),
                )
              else if (state.isError && state.favorites.isEmpty)
                ErrorState(
                  title:
                      state.errorMsg ?? LocaleKeys.errorLoadingFavorites.tr(),
                  subtitle: LocaleKeys.pullToRefresh.tr(),
                )
              else if (state.favorites.isEmpty)
                EmptyState(
                  title: LocaleKeys.yourSecureBranchVaultIsEmpty.tr(),
                  subtitle: LocaleKeys.addBranchesToFavorite.tr(),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.all(20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((
                      BuildContext context,
                      int index,
                    ) {
                      return BranchCardView(branch: state.favorites[index])
                          .animate()
                          .fadeIn(duration: 400.ms, delay: (index * 60).ms)
                          .slideX(
                            begin: 0.2,
                            end: 0,
                            curve: Curves.easeOutCubic,
                          );
                    }, childCount: state.favorites.length),
                  ),
                ),

              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          ),
        );
      },
    );
  }
}
