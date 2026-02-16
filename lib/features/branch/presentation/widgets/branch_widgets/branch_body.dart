import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/features/branch/presentation/cubits/branches_cubit/branches_cubit.dart';
import 'package:secure_branch_app/features/branch/presentation/widgets/branch_widgets/index.dart';
import 'package:secure_branch_app/features/branch/shimmers/branch_shimmer_view.dart';

class BranchBody extends StatelessWidget {
  const BranchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchesCubit, BranchesState>(
      builder: (BuildContext context, BranchesState state) {
        final List<BranchesResponseModel> branches =
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
              else if (state.isLoaded && (branches.isEmpty))
                const SizedBox.shrink()
              else
                SliverPadding(
                  padding: EdgeInsets.all(20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) =>
                          BranchCardView(branch: branches[index])
                              .animate()
                              .fadeIn(duration: 400.ms, delay: (index * 50).ms)
                              .moveY(begin: 20, end: 0),
                      childCount: branches.length,
                    ),
                  ),
                ),

              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            ],
          ),
        );
      },
    );
  }
}
