import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:toastification/toastification.dart';

class ToastManager {
  static final ToastManager _instance = ToastManager._internal();

  factory ToastManager() => _instance;

  ToastManager._internal();

  void success({
    required BuildContext context,
    required String message,
    String? description,
    int? autoCloseDuration,
  }) {
    toastification.show(
      borderSide: const BorderSide(color: AppColors.primary),
      backgroundColor: Theme.of(context).colorScheme.primary,
      context: context,
      icon: const Icon(Icons.fax_rounded),
      style: ToastificationStyle.flat,
      title: Text(
        message,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 13.sp,
            ),
      ),
      description: description != null
          ? Text(
              description,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 13.sp,
                  ),
            )
          : const SizedBox.shrink(),
      alignment: Alignment.topCenter,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: <BoxShadow>[
        const BoxShadow(
          color: AppColors.primary,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
        const BoxShadow(
          color: AppColors.primary,
          blurRadius: 4,
        ),
      ],
      direction: context.locale.languageCode == 'en'
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      showProgressBar: false,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.none,
      ),
      autoCloseDuration: Duration(
        seconds: autoCloseDuration ?? 3,
      ),
    );
  }

  void error({
    required BuildContext context,
    required String message,
    required String description,
    int? autoCloseDuration,
  }) {
    toastification.show(
      backgroundColor:Theme.of(context).colorScheme.primary ,
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      title: Text(
        message,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 13.sp,
            ),
      ),
      description: Text(
        description,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 13.sp,
            ),
      ),
      alignment: Alignment.center,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: highModeShadow,
      direction: context.locale.languageCode == 'en'
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      showProgressBar: false,
      autoCloseDuration: Duration(seconds: autoCloseDuration ?? 3),
    );
  }

  void warning({
    required BuildContext context,
    required String message,
    required String description,
    int? autoCloseDuration,
  }) {
    toastification.show(
      backgroundColor:Theme.of(context).colorScheme.primary ,
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.flat,
      title: Text(
        message,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
      ),
      description: Text(
        description,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.shadow,
              fontSize: 14.sp,
            ),
      ),
      alignment: Alignment.center,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: highModeShadow,
      direction: context.locale.languageCode == 'en'
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      showProgressBar: false,
      autoCloseDuration: Duration(seconds: autoCloseDuration ?? 3),
    );
  }

  void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColors.red500Base,
      textColor: AppColors.primaryWhite,
      fontSize: 16.sp,
    );
  }
}
