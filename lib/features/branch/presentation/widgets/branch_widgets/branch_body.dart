import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/common_widgets/branch_card_view.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/features/branch/presentation/cubits/branches_cubit/branches_cubit.dart';
import 'package:secure_branch_app/features/branch/presentation/shimmers/branch_shimmer_view.dart';
import 'package:secure_branch_app/features/branch/presentation/widgets/branch_widgets/index.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class BranchBody extends StatelessWidget {
  const BranchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchesCubit, BranchesState>(
      builder: (BuildContext context, BranchesState state) {
        final List<BranchWithDistance> nearest =
            state.nearestBranches ?? <BranchWithDistance>[];
        final List<BranchesResponseModel> others =
            state.otherBranches ?? <BranchesResponseModel>[];
        final List<BranchesResponseModel> allBranches =
            state.responseModel ?? <BranchesResponseModel>[];

        return RefreshIndicator(
          color: AppColors.accent,
          onRefresh: () => context.read<BranchesCubit>().getBranches(),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 180.h,
                pinned: true,
                stretch: true,
                backgroundColor: AppColors.primaryDark,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30.r),
                  ),
                ),
                flexibleSpace: const BranchesAppBar(),
              ),

              if (state.isLoading || state.isInitial)
                const SliverFillRemaining(child: BranchShimmerView())
              else if (state.isError)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      state.errorMsg ?? '',
                      style: const TextStyle(color: AppColors.error),
                    ),
                  ),
                )
              else ...<Widget>[
                if (state.hasLocation && nearest.isNotEmpty) ...<Widget>[
                  SliverToBoxAdapter(
                    child:
                        SectionHeader(
                              icon: Icons.near_me_rounded,
                              iconColor: AppColors.accent,
                              title: LocaleKeys.nearestBranches.tr(),
                              subtitle: LocaleKeys.nearestBranchesSubtitle.tr(
                                namedArgs: <String, String>{
                                  'count': nearest.length.toString(),
                                },
                              ),
                              badgeText: LocaleKeys.nearYou.tr(),
                              badgeColor: AppColors.accent,
                            )
                            .animate()
                            .fadeIn(duration: 400.ms)
                            .slideY(begin: 0.1, end: 0),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((
                        BuildContext context,
                        int index,
                      ) {
                        final BranchWithDistance item = nearest[index];
                        return NearestBranchCard(
                              branch: item.branch,
                              distanceKm: item.distanceKm,
                              rank: index + 1,
                            )
                            .animate()
                            .fadeIn(duration: 350.ms, delay: (index * 40).ms)
                            .moveY(begin: 15, end: 0);
                      }, childCount: nearest.length),
                    ),
                  ),
                ],

                if (state.hasLocation && others.isNotEmpty) ...<Widget>[
                  SliverToBoxAdapter(
                    child: SectionHeader(
                      icon: Icons.location_city_rounded,
                      iconColor: AppColors.primaryLight,
                      title: LocaleKeys.allBranches.tr(),
                      subtitle: LocaleKeys.allBranchesSubtitle.tr(
                        namedArgs: <String, String>{
                          'count': others.length.toString(),
                        },
                      ),
                      badgeText: LocaleKeys.allLocations.tr(),
                      badgeColor: AppColors.primaryLight,
                    ).animate().fadeIn(duration: 400.ms),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) =>
                            BranchCardView(branch: others[index])
                                .animate()
                                .fadeIn(
                                  duration: 350.ms,
                                  delay: (index * 30).ms,
                                )
                                .moveY(begin: 15, end: 0),
                        childCount: others.length,
                      ),
                    ),
                  ),
                ],

                if (!state.hasLocation && allBranches.isNotEmpty) ...<Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.info_outline,
                            size: 16.sp,
                            color: AppColors.warning,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              LocaleKeys.locationPermissionDenied.tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(20.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) =>
                            BranchCardView(branch: allBranches[index])
                                .animate()
                                .fadeIn(
                                  duration: 350.ms,
                                  delay: (index * 30).ms,
                                )
                                .moveY(begin: 15, end: 0),
                        childCount: allBranches.length,
                      ),
                    ),
                  ),
                ],
              ],

              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
            ],
          ),
        );
      },
    );
  }
}
