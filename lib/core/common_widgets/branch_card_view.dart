import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/assets/app_icons.dart';
import 'package:secure_branch_app/core/common_widgets/app_static_button.dart';
import 'package:secure_branch_app/core/common_widgets/toast_manager.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/core/helpers/app_helper_functions.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/features/branch/presentation/widgets/branch_widgets/index.dart';
import 'package:secure_branch_app/features/favorites/presentation/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class BranchCardView extends StatelessWidget {
  final BranchesResponseModel branch;

  const BranchCardView({required this.branch, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primaryBlack.withValueOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  branch.name ?? '__',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
              ),
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (BuildContext context, FavoritesState favState) {
                  final bool isFav = favState.isFavorite(branch.id);
                  return GestureDetector(
                    onTap: () =>
                        context.read<FavoritesCubit>().toggleFavorite(branch),
                    child: SvgPicture.asset(
                      isFav
                          ? AppIcons.mingcuteLoveFillIcon
                          : AppIcons.mingcuteLoveIcon,
                    ),
                    // child: Icon(
                    //   isFav
                    //       ? Icons.favorite_rounded
                    //       : Icons.favorite_border_rounded,
                    //   color: isFav ? AppColors.error : AppColors.textSecondary,
                    //   size: 22.sp,
                    // ),
                  );
                },
              ),
              SizedBox(width: 8.w),
              BranchStatusIndicator(isActive: branch.isActive ?? false),
            ],
          ),
          SizedBox(height: 4.h),

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
                  branch.address ?? LocaleKeys.noAddressAvailable.tr(),
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

          Divider(height: 24.h, color: AppColors.divider),

          Row(
            children: <Widget>[
              if (branch.workingHours != null)
                InfoTitle(icon: Icons.access_time, text: branch.workingHours!),
              SizedBox(width: 16.w),
              if (branch.phone != null)
                InfoTitle(icon: Icons.phone_outlined, text: branch.phone!),
            ],
          ),

          SizedBox(height: 16.h),
          if (branch.lat != null && branch.lng != null)
            AppStaticButton(
              onTap: () async {
                try {
                  await AppHelperFunctions().openMap(branch.lat, branch.lng);
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
              buttonColor: AppColors.primaryLight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(LocaleKeys.navigateToBranch.tr()),
                  SizedBox(width: 4.w),
                  const Icon(Icons.directions_outlined, size: 18),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
