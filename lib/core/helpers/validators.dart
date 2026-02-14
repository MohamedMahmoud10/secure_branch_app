import 'package:easy_localization/easy_localization.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class Validators {
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

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.passwordRequired.tr();
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
