import 'package:easy_localization/easy_localization.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class Validators {

  static bool isValidEmail(String value) {
    final RegExp emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(value.trim());
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.emailRequired.tr();
    }
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return LocaleKeys.invalidEmail.tr();
    }
    return null;
  }

  /// Minimum length for a strong password.
  static const int minPasswordLength = 8;

  /// Returns true if password has at least [minPasswordLength] and
  /// contains at least one letter and one number.
  static bool isStrongPassword(String value) {
    if (value.length < minPasswordLength) return false;
    final bool hasLetter = RegExp('[a-zA-Z]').hasMatch(value);
    final bool hasNumber = RegExp('[0-9]').hasMatch(value);
    return hasLetter && hasNumber;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.passwordRequired.tr();
    }
    if (value.length < minPasswordLength) {
      return LocaleKeys.passwordTooShort.tr();
    }
    if (!isStrongPassword(value)) {
      return LocaleKeys.passwordWeak.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.confirmPasswordRequired.tr();
    }
    if (value.trim() != password.trim()) {
      return LocaleKeys.passwordsDoNotMatch.tr();
    }
    return null;
  }

  static String? validateEmptyField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName.tr()} ${LocaleKeys.fieldRequired.tr()}';
    }
    return null;
  }

}
