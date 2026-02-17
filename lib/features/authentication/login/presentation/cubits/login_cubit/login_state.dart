part of 'login_cubit.dart';


extension LoginStateX on LoginState {
  bool get isInitial => status == GenericStateStatus.initial;

  bool get isLoading => status == GenericStateStatus.loading;

  bool get isLoaded => status == GenericStateStatus.loaded;

  bool get isError => status == GenericStateStatus.error;

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
class LoginState extends Equatable implements LoadableState {
  final GenericStateStatus status;
  final String? errorMsg;
  final UserDataModel? userDataModel;
  final bool? isValidForm;
  final Map<String, String>? validationErrors;
  final BiometricEnrollmentStatus biometricEnrollmentStatus;

  const LoginState({
    required this.status,
    this.userDataModel,
    this.errorMsg,
    this.isValidForm = false,
    this.validationErrors,
    this.biometricEnrollmentStatus = BiometricEnrollmentStatus.idle,
  });

  LoginState copyWith({
    GenericStateStatus? status,
    String? errorMsg,
    UserDataModel? userDataModel,
    bool? isValidForm,
    Map<String, String>? validationErrors,
    BiometricEnrollmentStatus? biometricEnrollmentStatus,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      userDataModel: userDataModel ?? this.userDataModel,
      isValidForm: isValidForm ?? this.isValidForm,
      validationErrors: validationErrors ?? this.validationErrors,
      biometricEnrollmentStatus:
          biometricEnrollmentStatus ?? this.biometricEnrollmentStatus,
    );
  }

  @override
  String toString() {
    return '''LoginState(status: $status, errorMsg: $errorMsg, userDataModel: $userDataModel, isValidForm: $isValidForm, biometric: $biometricEnrollmentStatus)''';
  }

  @override
  bool get isLoading => status == GenericStateStatus.loading;

  @override
  List<Object?> get props => <Object?>[
    status,
    errorMsg,
    userDataModel,
    isValidForm,
    validationErrors,
    biometricEnrollmentStatus,
  ];
}
