import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';

part 'branches_response_model.freezed.dart';

part 'branches_response_model.g.dart';

@Freezed(fromJson: true, toJson: false)
abstract class BranchesResponseModel with _$BranchesResponseModel {
  @HiveType(typeId: 2, adapterName: 'BranchesAdapter')
  factory BranchesResponseModel({
    @HiveField(0) required String id,
    @HiveField(1) String? name,
    @HiveField(2) String? type,
    @HiveField(3) String? address,
    @HiveField(4) double? lat,
    @HiveField(5) double? lng,
    @HiveField(6) @JsonKey(name: 'is_active') bool? isActive,
    @HiveField(7) List<String>? services,
    @HiveField(8) String? phone,
    @HiveField(9) @JsonKey(name: 'working_hours') String? workingHours,
  }) = _BranchesResponseModel;

  BranchesResponseModel._();

  factory BranchesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BranchesResponseModelFromJson(json);
}
