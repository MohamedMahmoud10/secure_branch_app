import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/common_widgets/app_static_button.dart';
import 'package:secure_branch_app/core/common_widgets/toast_manager.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/core/helpers/app_helper_functions.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/features/branch/presentation/widgets/branch_widgets/index.dart';
import 'package:secure_branch_app/features/favorites/presentation/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class NearestBranchCard extends StatelessWidget {
  const NearestBranchCard({
    required this.branch,
    required this.distanceKm,
    required this.rank,
    super.key,
  });

  final BranchesResponseModel branch;
  final double distanceKm;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final String formattedDistance = distanceKm < 1
        ? '${(distanceKm * 1000).toStringAsFixed(0)} m'
        : '${distanceKm.toStringAsFixed(1)} km';

    final bool isBranch =
        branch.type?.toLowerCase() == 'branch' || branch.type == null;

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.accent.withValueOpacity(0.3)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.accent.withValueOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Container(
              width: 4.w,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  bottomLeft: Radius.circular(16.r),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                AppColors.accent,
                                AppColors.accent.withValueOpacity(0.7),
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '#$rank',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            branch.name ?? '__',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        BlocBuilder<FavoritesCubit, FavoritesState>(
                          builder:
                              (BuildContext context, FavoritesState favState) {
                            final bool isFav =
                                favState.isFavorite(branch.id);
                            return GestureDetector(
                              onTap: () => context
                                  .read<FavoritesCubit>()
                                  .toggleFavorite(branch),
                              child: Icon(
                                isFav
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: isFav
                                    ? AppColors.error
                                    : AppColors.textSecondary,
                                size: 20.sp,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: isBranch
                                ? AppColors.primary.withValueOpacity(0.1)
                                : AppColors.warning.withValueOpacity(0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            isBranch
                                ? LocaleKeys.branch.tr()
                                : LocaleKeys.atm.tr(),
                            style: TextStyle(
                              color: isBranch
                                  ? AppColors.primary
                                  : AppColors.warning,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        BranchStatusIndicator(
                          isActive: branch.isActive ?? false,
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            branch.address ??
                                LocaleKeys.noAddressAvailable.tr(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                AppColors.accent.withValueOpacity(0.15),
                                AppColors.accent.withValueOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.directions_walk_rounded,
                                size: 13.sp,
                                color: AppColors.accentDark,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                formattedDistance,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accentDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        if (branch.workingHours != null)
                          InfoTitle(
                            icon: Icons.access_time,
                            text: branch.workingHours!,
                          ),
                        if (branch.workingHours != null && branch.phone != null)
                          SizedBox(width: 12.w),
                        if (branch.phone != null)
                          Flexible(
                            child: InfoTitle(
                              icon: Icons.phone_outlined,
                              text: branch.phone!,
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    if (branch.lat != null && branch.lng != null)
                      AppStaticButton(
                        onTap: () async {
                          try {
                            await AppHelperFunctions().openMap(
                              branch.lat,
                              branch.lng,
                            );
                          } catch (e) {
                            if (context.mounted) {
                              ToastManager().error(
                                context: context,
                                message: LocaleKeys.error.tr(),
                                description: e.toString(),
                              );
                            }
                          }
                        },
                        buttonName: LocaleKeys.navigateToBranch.tr(),
                        buttonColor: AppColors.accent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.directions_outlined,
                              size: 18.sp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              '$formattedDistance — ${LocaleKeys.navigateToBranch.tr()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
