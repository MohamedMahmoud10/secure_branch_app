import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';

class SliverTransactionList extends StatelessWidget {
  const SliverTransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = <Map<String, dynamic>>[
      <String, dynamic>{
        'title': 'Apple Store',
        'date': 'Today, 12:40 PM',
        'amount': r'- $1,299.00',
        'icon': Icons.laptop_mac,
        'color': Colors.black,
      },
      <String, dynamic>{
        'title': 'Vault Transfer',
        'date': 'Yesterday',
        'amount': r'+ $5,000.00',
        'icon': Icons.shield_outlined,
        'color': AppColors.accent,
      },
      <String, dynamic>{
        'title': 'Amazon Prime',
        'date': 'Feb 14, 2026',
        'amount': r'- $14.99',
        'icon': Icons.shopping_cart_outlined,
        'color': Colors.orange,
      },
      <String, dynamic>{
        'title': 'Starbucks',
        'date': 'Feb 13, 2026',
        'amount': r'- $5.50',
        'icon': Icons.coffee_outlined,
        'color': Colors.brown,
      },
    ];

    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        final Map<String, dynamic> item = transactions[index];
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
            leading: CircleAvatar(
              backgroundColor: (item['color'] as Color).withValueOpacity(0.1),
              child: Icon(
                item['icon'] as IconData,
                color: item['color'] as Color,
                size: 20,
              ),
            ),
            title: Text(
              item['title'] as String,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            subtitle: Text(
              item['date'] as String,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
            ),
            trailing: Text(
              item['amount'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: (item['amount'] as String).contains('+')
                    ? AppColors.success
                    : AppColors.textPrimary,
              ),
            ),
          ),
        );
      }, childCount: transactions.length),
    );
  }
}
