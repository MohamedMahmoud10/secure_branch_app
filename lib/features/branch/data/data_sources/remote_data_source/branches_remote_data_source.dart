import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/config/app_constant_strings.dart';
import 'package:secure_branch_app/core/infrastructure/network/api_consumer.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

List<BranchesResponseModel> _parseBranches(String rawJson) {
  final List<dynamic> list = jsonDecode(rawJson) as List<dynamic>;
  return list
      .map((dynamic e) => BranchesResponseModel.fromJson(e as Map<String, dynamic>))
      .toList();
}

@lazySingleton
class BranchesRemoteDataSource {
  final ApiConsumer _client;

  BranchesRemoteDataSource(this._client);

  Future<List<BranchesResponseModel>> getBranches() async {
    try {
      final dynamic response = await _client.get(
        path: dotenv.get(AppConstantStrings.branches),
        responseType: ResponseType.plain,
      );

      final String raw = response as String;
      return compute(_parseBranches, raw);
    } catch (e) {
      AppLogger().error('Error From Branches Response Model: $e');
      rethrow;
    }
  }
}
