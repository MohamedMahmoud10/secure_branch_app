part of 'register_cubit.dart';


extension RegisterStateX on RegisterState {
  bool get isInitial => status == GenericStateStatus.initial;

  bool get isLoading => status == GenericStateStatus.loading;

  bool get isLoaded => status == GenericStateStatus.loaded;

  bool get isError => status == GenericStateStatus.error;

  bool get isFieldsIsNotEmpty => status == GenericStateStatus.validationError;

  bool get isBiometricEnrolling =>
      biometricEnrollmentStatus == BiometricEnrollmentStatus.enrolling;

  bool get isBiometricEnrolled =>
      biometricEnrollmentStatus == BiometricEnrollmentStatus.enrolled;

  bool get isBiometricFailed =>
      biometricEnrollmentStatus == BiometricEnrollmentStatus.failed;

  bool get isBiometricUnavailable =>
      biometricEnrollmentStatus == BiometricEnrollmentStatus.unavailable;
}

@immutable
class RegisterState extends Equatable implements LoadableState {
  final GenericStateStatus status;
  final String? errorMsg;
  final bool? isValidForm;
  final String? userId;
  final Map<String, String>? validationErrors;
  final BiometricEnrollmentStatus biometricEnrollmentStatus;
  final UserDataModel? responseModel;

  const RegisterState({
    required this.status,
    this.errorMsg,
    this.isValidForm = false,
    this.userId,
    this.validationErrors,
    this.responseModel,
    this.biometricEnrollmentStatus = BiometricEnrollmentStatus.idle,
  });

  RegisterState copyWith({
    GenericStateStatus? status,
    String? errorMsg,
    bool? isValidForm,
    String? userId,
    Map<String, String>? validationErrors,
    BiometricEnrollmentStatus? biometricEnrollmentStatus,
    UserDataModel? responseModel,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      isValidForm: isValidForm ?? this.isValidForm,
      userId: userId ?? this.userId,
      validationErrors: validationErrors,
      biometricEnrollmentStatus:
          biometricEnrollmentStatus ?? this.biometricEnrollmentStatus,
      responseModel:
      responseModel ?? this.responseModel,
    );
  }

  @override
  String toString() {
    return '''RegisterState(status: $status, errorMsg: $errorMsg, isValidForm: $isValidForm, biometric: $biometricEnrollmentStatus)''';
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
    biometricEnrollmentStatus,
    responseModel,
  ];
}
