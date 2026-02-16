import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/common_widgets/custom_text_form_field.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class AddTransactionBottomSheet extends StatelessWidget {
  const AddTransactionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> categories = <Map<String, Object>>[
      <String, Object>{'icon': Icons.shopping_bag_outlined, 'label': 'Shop'},
      <String, Object>{'icon': Icons.restaurant_rounded, 'label': 'Food'},
      <String, Object>{
        'icon': Icons.directions_car_filled_outlined,
        'label': 'Transport',
      },
      <String, Object>{'icon': Icons.more_horiz_rounded, 'label': 'Other'},
    ];

    return Container(
      padding: EdgeInsets.all(
        24.w,
      ).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValueOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          Text(
            LocaleKeys.newTransaction.tr(),
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
          Text(
            LocaleKeys.recordSecureLedgerEntry.tr(),
            style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
          ),
          SizedBox(height: 24.h),

          CustomTextFormField(
            hintText: LocaleKeys.merchantRecipient.tr(),
            prefixIcon: const Icon(Icons.storefront_outlined),
            textEditingController: TextEditingController(),
          ),
          SizedBox(height: 16.h),

          CustomTextFormField(
            hintText: LocaleKeys.amount.tr(),
            prefixIcon: const Icon(Icons.attach_money_rounded),
            textEditingController: TextEditingController(),
          ),

          SizedBox(height: 16.h),

          Text(
            LocaleKeys.transactionCategory.tr(),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: categories
                .map(
                  (Map<String, Object> cat) => Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 26.r,
                        backgroundColor: AppColors.background,
                        child: Icon(
                          cat['icon']! as IconData,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        cat['label']! as String,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),

          SizedBox(height: 32.h),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 58.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
              elevation: 0,
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              LocaleKeys.encryptAndPushToLedger.tr(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
