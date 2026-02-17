import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

extension TransactionCategoryExtension on TransactionCategory {
  String toJson() {
    switch (this) {
      case TransactionCategory.shop:
        return 'shop';
      case TransactionCategory.food:
        return 'food';
      case TransactionCategory.transport:
        return 'transport';
      case TransactionCategory.other:
        return 'other';
    }
  }

  static TransactionCategory fromJson(String? value) {
    switch (value) {
      case 'shop':
        return TransactionCategory.shop;
      case 'food':
        return TransactionCategory.food;
      case 'transport':
        return TransactionCategory.transport;
      case 'other':
        return TransactionCategory.other;
      default:
        return TransactionCategory.other;
    }
  }

  String get translationKey {
    switch (this) {
      case TransactionCategory.shop:
        return LocaleKeys.shop.tr();
      case TransactionCategory.food:
        return LocaleKeys.food.tr();
      case TransactionCategory.transport:
        return LocaleKeys.transport.tr();
      case TransactionCategory.other:
        return LocaleKeys.otherText.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionCategory.shop:
        return Icons.shopping_bag_outlined;
      case TransactionCategory.food:
        return Icons.restaurant_rounded;
      case TransactionCategory.transport:
        return Icons.directions_car_filled_outlined;
      case TransactionCategory.other:
        return Icons.more_horiz_rounded;
    }
  }

  Color get color {
    switch (this) {
      case TransactionCategory.shop:
        return Colors.black;
      case TransactionCategory.food:
        return AppColors.accent;
      case TransactionCategory.transport:
        return Colors.orange;
      case TransactionCategory.other:
        return Colors.brown;
    }
  }
}
