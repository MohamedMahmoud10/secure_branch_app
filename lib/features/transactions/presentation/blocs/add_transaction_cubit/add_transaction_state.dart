part of 'add_transaction_cubit.dart';

extension AddTransactionStateX on AddTransactionState {
  bool get isInitial => status == GenericStateStatus.initial;

  bool get isLoading => status == GenericStateStatus.loading;

  bool get isLoaded => status == GenericStateStatus.loaded;

  bool get isError => status == GenericStateStatus.error;

  bool get isFieldsIsNotEmpty => status == GenericStateStatus.validationError;
}

@immutable
class AddTransactionState extends Equatable implements LoadableState {
  final GenericStateStatus status;
  final String? errorMsg;
  final bool? isValidForm;
  final String? userId;
  final Map<String, String>? validationErrors;
  final TransactionCategory? selectedCategory;
  const AddTransactionState({
    required this.status,
    this.errorMsg,
    this.isValidForm = false,
    this.userId,
    this.validationErrors,
    this.selectedCategory,
  });

  AddTransactionState copyWith({
    GenericStateStatus? status,
    String? errorMsg,
    bool? isValidForm,
    String? userId,
    Map<String, String>? validationErrors,
    TransactionCategory? selectedCategory,
  }) {
    return AddTransactionState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      isValidForm: isValidForm ?? this.isValidForm,
      userId: userId ?? this.userId,
      validationErrors: validationErrors ?? this.validationErrors,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  String toString() {
    return '''AddTransactionState(status: $status,errorMsg: $errorMsg , isValidForm :$isValidForm, selectedCategory :$selectedCategory, )''';
  }

  @override
  bool get isLoading => status == GenericStateStatus.loading;

  @override
  List<Object?> get props => <Object?>[
    status,
    errorMsg,
    isValidForm,
    userId,
    validationErrors,
    selectedCategory,
  ];
}
