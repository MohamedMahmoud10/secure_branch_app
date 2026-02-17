part of 'branches_cubit.dart';

extension BranchesStateX on BranchesState {
  bool get isInitial => status == GenericStateStatus.initial;

  bool get isLoading => status == GenericStateStatus.loading;

  bool get isLoaded => status == GenericStateStatus.loaded;

  bool get isError => status == GenericStateStatus.error;
}

@immutable
class BranchesState extends Equatable {
  final GenericStateStatus status;
  final String? errorMsg;

  final List<BranchesResponseModel>? responseModel;

  final List<BranchWithDistance>? nearestBranches;

  final List<BranchesResponseModel>? otherBranches;

  final bool hasLocation;

  const BranchesState({
    required this.status,
    this.errorMsg,
    this.responseModel,
    this.nearestBranches,
    this.otherBranches,
    this.hasLocation = false,
  });

  BranchesState copyWith({
    GenericStateStatus? status,
    String? errorMsg,
    List<BranchesResponseModel>? responseModel,
    List<BranchWithDistance>? nearestBranches,
    List<BranchesResponseModel>? otherBranches,
    bool? hasLocation,
  }) {
    return BranchesState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      responseModel: responseModel ?? this.responseModel,
      nearestBranches: nearestBranches ?? this.nearestBranches,
      otherBranches: otherBranches ?? this.otherBranches,
      hasLocation: hasLocation ?? this.hasLocation,
    );
  }

  @override
  String toString() {
    return '''BranchesState(status: $status, errorMsg: $errorMsg, nearest: ${nearestBranches?.length}, other: ${otherBranches?.length})''';
  }

  @override
  List<Object?> get props => <Object?>[
    errorMsg,
    status,
    responseModel,
    nearestBranches,
    otherBranches,
    hasLocation,
  ];
}

class BranchWithDistance extends Equatable {
  final BranchesResponseModel branch;
  final double distanceKm;

  const BranchWithDistance({required this.branch, required this.distanceKm});

  @override
  List<Object?> get props => <Object?>[branch, distanceKm];
}
