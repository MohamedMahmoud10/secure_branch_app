import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/widgets_extensions.dart';
import 'package:secure_branch_app/core/utilities/generic_classes/generic.dart';

class CustomLoadingButton<C extends Cubit<S>, S extends LoadableState?>
    extends StatelessWidget {
  const CustomLoadingButton({
    required this.onTap,
    super.key,
    this.text,
    this.height,
    this.errorCallBack,
    this.width,
    this.backGroundColor,
    this.borderColor,
    this.textColor,
    this.unClickableButtonColor,
    this.borderRadius,
    this.child,
    this.cubit,
    this.loadingState,
    this.isClickable = true,
    this.applyWhiteColor = true,
    this.hasGradientColor = true,
  });

  final String? text;
  final VoidCallback onTap;
  final VoidCallback? errorCallBack;
  final double? height;
  final double? width;
  final Color? backGroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? unClickableButtonColor;
  final bool? isClickable;
  final double? borderRadius;
  final Widget? child;
  final Cubit<dynamic>? cubit;
  final dynamic loadingState;
  final bool? applyWhiteColor;
  final bool? hasGradientColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      bloc: cubit! as C,
      builder: (BuildContext context, LoadableState? state) {
        final bool isLoading = state!.isLoading;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            maximumSize: Size(width ?? 343.w, height ?? 48.h),
            minimumSize: Size(width ?? 343.w, height ?? 48.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            ),
            padding: EdgeInsets.zero,
            elevation: 0,
          ),
          onPressed: isClickable! && !isLoading ? onTap : errorCallBack,
          child: AnimatedContainer(
            width: width ?? 343.w,
            height: height ?? 48.h,
            decoration: BoxDecoration(
              color: isClickable!
                  ? backGroundColor ?? Theme.of(context).colorScheme.onTertiary
                  : unClickableButtonColor ?? AppColors.textHint,
              borderRadius: BorderRadius.circular(8.r),
            ),
            duration: const Duration(milliseconds: 300),
            child: isLoading
                ? Center(
                    child: SpinKitRing(
                      color: AppColors.primaryWhite,
                      size: 30.sp,
                      lineWidth: 2.w,
                    ),
                  )
                : text != null
                ? AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: textColor ?? AppColors.primaryWhite,
                    ),
                    child: Text(text!).wrapCenter(),
                  )
                : child,
          ),
        );
      },
    );
  }
}
