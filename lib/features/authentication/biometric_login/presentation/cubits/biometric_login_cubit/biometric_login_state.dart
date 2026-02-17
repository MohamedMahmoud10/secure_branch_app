part of 'biometric_login_cubit.dart';

extension BiometricLoginStatusX on BiometricLoginState {
  bool get isAvailable => status == BiometricLoginStatus.available;

  bool get isAuthenticating => status == BiometricLoginStatus.authenticating;

  bool get isAuthenticated => status == BiometricLoginStatus.authenticated;

  bool get isError => status == BiometricLoginStatus.error;

  bool get isUnavailable => status == BiometricLoginStatus.unavailable;
}

@immutable
class BiometricLoginState extends Equatable {
  const BiometricLoginState({
    this.status = BiometricLoginStatus.initial,
    this.errorMsg,
    this.userDataModel,
  });

  final BiometricLoginStatus status;
  final String? errorMsg;
  final UserDataModel? userDataModel;

  BiometricLoginState copyWith({
    BiometricLoginStatus? status,
    String? errorMsg,
    UserDataModel? userDataModel,
  }) {
    return BiometricLoginState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      userDataModel: userDataModel ?? this.userDataModel,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, errorMsg, userDataModel];
}
