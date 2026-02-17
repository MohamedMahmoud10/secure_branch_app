part of 'add_transaction_cubit.dart';

extension AddTransactionStateX on AddTransactionState {
  bool get isInitial => status == GenericStateStatus.initial;

  bool get isLoading => status == GenericStateStatus.loading;

  bool get isLoaded => status == GenericStateStatus.loaded;

  bool get isError => status == GenericStateStatus.error;

  bool get isFieldsIsNotEmpty => status == GenericStateStatus.validationError;

  bool get isBiometricVerifying =>
      biometricStatus == TransactionBiometricStatus.verifying;

  bool get isBiometricFailed =>
      biometricStatus == TransactionBiometricStatus.failed;
}

@immutable
class AddTransactionState extends Equatable implements LoadableState {
  final GenericStateStatus status;
  final String? errorMsg;
  final bool? isValidForm;
  final String? userId;
  final Map<String, String>? validationErrors;
  final TransactionCategory? selectedCategory;
  final TransactionBiometricStatus biometricStatus;

  const AddTransactionState({
    required this.status,
    this.errorMsg,
    this.isValidForm = false,
    this.userId,
    this.validationErrors,
    this.selectedCategory,
    this.biometricStatus = TransactionBiometricStatus.idle,
  });

  AddTransactionState copyWith({
    GenericStateStatus? status,
    String? errorMsg,
    bool? isValidForm,
    String? userId,
    Map<String, String>? validationErrors,
    TransactionCategory? selectedCategory,
    TransactionBiometricStatus? biometricStatus,
  }) {
    return AddTransactionState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      isValidForm: isValidForm ?? this.isValidForm,
      userId: userId ?? this.userId,
      validationErrors: validationErrors ?? this.validationErrors,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      biometricStatus: biometricStatus ?? this.biometricStatus,
    );
  }

  @override
  String toString() {
    return '''AddTransactionState(status: $status, errorMsg: $errorMsg, isValidForm: $isValidForm, selectedCategory: $selectedCategory, biometric: $biometricStatus)''';
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
    biometricStatus,
  ];
}
