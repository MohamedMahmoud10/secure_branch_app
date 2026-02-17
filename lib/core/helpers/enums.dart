enum GenericStateStatus {
  initial,
  loading,
  loaded,
  error,
  changeUi,
  validationError,
}

enum TransactionCategory { shop, food, transport, other }

enum BiometricStatus { noHardware, notEnrolled, failure }

enum BiometricLoginStatus {
  initial,
  checking,
  available,
  unavailable,
  authenticating,
  authenticated,
  error,
}

enum BiometricEnrollmentStatus {
  idle,
  enrolling,
  unavailable,
  enrolled,
  failed,
}
enum TransactionBiometricStatus {
  idle,

  verifying,

  verified,

  failed,
}
