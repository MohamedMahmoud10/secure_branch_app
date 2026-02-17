part of 'transactions_bloc.dart';

extension TransactionsStateX on TransactionsState {
  bool get isInitial => status == GenericStateStatus.initial;

  bool get isLoading => status == GenericStateStatus.loading;

  bool get isLoaded => status == GenericStateStatus.loaded;

  bool get isError => status == GenericStateStatus.error;
}

@immutable
final class TransactionsState extends Equatable {
  final GenericStateStatus status;
  final List<TransactionsModels>? responseModel;

  final String? errorMsg;

  const TransactionsState({
    required this.status,
    this.errorMsg,
    this.responseModel,
  });

  TransactionsState copyWith({
    GenericStateStatus? status,
    String? errorMsg,
    List<TransactionsModels>? responseModel,
  }) {
    return TransactionsState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      responseModel: responseModel ?? this.responseModel,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, errorMsg, responseModel];

  @override
  String toString() {
    return '''
    CommentsState( 
    status:$status,
    errorMsg:$errorMsg,
    responseModel:$responseModel,
    ''';
  }
}
