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

  const BranchesState({
    required this.status,
    this.errorMsg,
    this.responseModel,
  });

  BranchesState copyWith({
    GenericStateStatus? status,
    String? errorMsg,
    List<BranchesResponseModel>? responseModel,
  }) {
    return BranchesState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      responseModel: responseModel ?? this.responseModel,
    );
  }

  @override
  String toString() {
    return '''BranchesState(status: $status,errorMsg: $errorMsg   )''';
  }

  @override
  List<Object?> get props => <Object?>[errorMsg, status, responseModel];
}
