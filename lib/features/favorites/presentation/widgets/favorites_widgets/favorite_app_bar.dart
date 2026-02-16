import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class FavoriteAppBar extends StatelessWidget {
  const FavoriteAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        LocaleKeys.vault.tr().toUpperCase(),
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
          color: AppColors.primaryWhite,
        ),
      ).animate().fadeIn(delay: 300.ms),
      background: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[AppColors.primaryDark, AppColors.primary],
              ),
            ),
          ),
          PositionedDirectional(
            start: -30,
            top: -20,
            child: Icon(
              Icons.lock_person_outlined,
              size: 180.r,
              color: Colors.white.withValueOpacity(0.05),
            ),
          ),
        ],
      ),
    );
  }
}
