import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:secure_branch_app/core/extensions/transaction_category_extension.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';

class DateTimeConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeConverter();

  @override
  DateTime fromJson(Timestamp json) => json.toDate();

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}

class TransactionCategoryConverter
    implements JsonConverter<TransactionCategory, String?> {
  const TransactionCategoryConverter();

  @override
  TransactionCategory fromJson(String? json) {
    return TransactionCategoryExtension.fromJson(json);
  }

  @override
  String? toJson(TransactionCategory object) {
    return object.toJson();
  }
}
