part of 'login_cubit.dart';

extension RegisterStateX on LoginState {
  bool get isInitial => status == GenericStateStatus.initial;

  bool get isLoading => status == GenericStateStatus.loading;

  bool get isLoaded => status == GenericStateStatus.loaded;

  bool get isError => status == GenericStateStatus.error;
}

@immutable
class LoginState extends Equatable implements LoadableState {
  final GenericStateStatus status;
  final String? errorMsg;
  final UserDataModel? userDataModel;
  final bool? isFormEmpty;
  final Map<String, String>? validationErrors;

  const LoginState({
    required this.status,
    this.userDataModel,
    this.errorMsg,
    this.isFormEmpty = true,
    this.validationErrors,
  });

  LoginState copyWith({
    GenericStateStatus? status,
    String? errorMsg,
    UserDataModel? userDataModel,
    bool? isFormEmpty,
    Map<String, String>? validationErrors,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      userDataModel: userDataModel ?? this.userDataModel,
      isFormEmpty: isFormEmpty ?? this.isFormEmpty,
      validationErrors: validationErrors ?? this.validationErrors,
    );
  }

  @override
  String toString() {
    return '''LoginState(status: $status,errorMsg: $errorMsg , userDataModel :$userDataModel, isFormEmpty:$isFormEmpty )''';
  }

  @override
  bool get isLoading => status == GenericStateStatus.loading;

  @override
  List<Object?> get props => <Object?>[
    status,
    errorMsg,
    userDataModel,
    isFormEmpty,
    validationErrors,
  ];
}
