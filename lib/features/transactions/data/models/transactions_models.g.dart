// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionsModels _$TransactionsModelsFromJson(Map<String, dynamic> json) =>
    _TransactionsModels(
      merchantName: json['merchant_name'] as String,
      amount: json['amount'] as num,
      category: const TransactionCategoryConverter().fromJson(
        json['category'] as String?,
      ),
      documentId: json['doc_id'] as String?,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
        json['createdAt'],
        const DateTimeConverter().fromJson,
      ),
    );

Map<String, dynamic> _$TransactionsModelsToJson(
  _TransactionsModels instance,
) => <String, dynamic>{
  'merchant_name': instance.merchantName,
  'amount': instance.amount,
  'category': ?const TransactionCategoryConverter().toJson(instance.category),
  'doc_id': ?instance.documentId,
  'createdAt': ?_$JsonConverterToJson<Timestamp, DateTime>(
    instance.createdAt,
    const DateTimeConverter().toJson,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
