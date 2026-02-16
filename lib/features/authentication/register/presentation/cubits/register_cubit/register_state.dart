part of 'register_cubit.dart';

extension RegisterStateX on RegisterState {
  bool get isInitial => status == GenericStateStatus.initial;

  bool get isLoading => status == GenericStateStatus.loading;

  bool get isLoaded => status == GenericStateStatus.loaded;

  bool get isError => status == GenericStateStatus.error;

  bool get isFieldsIsNotEmpty => status == GenericStateStatus.validationError;
}

@immutable
class RegisterState extends Equatable implements LoadableState {
  final GenericStateStatus status;
  final String? errorMsg;
  final bool? isFormEmpty;
  final String? userId;
  final Map<String, String>? validationErrors;

  const RegisterState({
    required this.status,
    this.errorMsg,
    this.isFormEmpty = true,
    this.userId,
    this.validationErrors,
  });

  RegisterState copyWith({
    GenericStateStatus? status,
    String? errorMsg,
    bool? isFormEmpty,
    String? userId,
    Map<String, String>? validationErrors,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      isFormEmpty: isFormEmpty ?? this.isFormEmpty,
      userId: userId ?? this.userId,
      validationErrors: validationErrors,
    );
  }

  @override
  String toString() {
    return '''RegisterState(status: $status,errorMsg: $errorMsg , isFormEmpty :$isFormEmpty, )''';
  }

  @override
  bool get isLoading => status == GenericStateStatus.loading;

  @override
  List<Object?> get props => <Object?>[
    status,
    errorMsg,
    isFormEmpty,
    userId,
    validationErrors,
  ];
}
