import 'package:secure_branch_app/core/helpers/enums.dart';

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
}
