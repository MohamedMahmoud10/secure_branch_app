import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/core/extensions/transaction_category_extension.dart';
import 'package:secure_branch_app/features/transactions/data/models/transactions_models.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({required this.transactionsModels, super.key});

  final TransactionsModels transactionsModels;

  @override
  Widget build(BuildContext context) {
    AppLogger().info('Created At Value Is ${transactionsModels.createdAt}');
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),

      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        leading: CircleAvatar(
          backgroundColor: transactionsModels.category.color.withValueOpacity(0.1),
          child: Icon(
            transactionsModels.category.icon,
            color: transactionsModels.category.color,
            size: 20,
          ),
        ),
        title: Text(
          transactionsModels.category.translationKey,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
        ),
        subtitle: Text(
          '${transactionsModels.createdAt}',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
        ),
        trailing: Text(
          '${transactionsModels.amount}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: '${transactionsModels.amount}'.contains('+')
                ? AppColors.success
                : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
