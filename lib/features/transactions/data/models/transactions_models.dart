import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/core/utilities/converters/app_converters.dart';

part 'transactions_models.g.dart';

part 'transactions_models.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
abstract class TransactionsModels with _$TransactionsModels {
  factory TransactionsModels({
    @JsonKey(name: 'merchant_name') required String merchantName,
    required num amount,

    @TransactionCategoryConverter() required TransactionCategory category,
    @JsonKey(name: 'doc_id') String? documentId,
    @DateTimeConverter() DateTime? createdAt,
  }) = _TransactionsModels;

  factory TransactionsModels.fromJson(Map<String, dynamic> json) =>
      _$TransactionsModelsFromJson(json);
}
