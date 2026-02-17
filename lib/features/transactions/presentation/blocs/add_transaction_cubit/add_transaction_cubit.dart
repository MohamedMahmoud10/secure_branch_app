import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/core/services/biometric_auth_service.dart';
import 'package:secure_branch_app/core/utilities/generic_classes/generic.dart';
import 'package:secure_branch_app/features/transactions/data/models/transactions_models.dart';
import 'package:secure_branch_app/features/transactions/data/repo/add_transaction_repo.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

part 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  final AddTransactionRepo _repo;
  final BiometricAuthService _biometricAuthService;

  AddTransactionCubit(this._repo, this._biometricAuthService)
    : super(const AddTransactionState(status: GenericStateStatus.initial)) {
    merchantNameController.addListener(validateAddTransactionFields);
    amountController.addListener(validateAddTransactionFields);
  }

  final TextEditingController merchantNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  Future<void> addTransaction() async {
    emit(
      state.copyWith(
        status: GenericStateStatus.loading,
        biometricStatus: TransactionBiometricStatus.verifying,
      ),
    );

    try {
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String challenge =
          '${merchantNameController.text.trim()}'
          ':${amountController.text.trim()}'
          ':${state.selectedCategory?.name}'
          ':$timestamp';

      AppLogger().info('Transaction biometric challenge: $challenge');

      final String? signature = await _biometricAuthService.createSignature(
        payload: challenge,
      );

      if (signature == null) {
        AppLogger().warning('Transaction biometric verification cancelled');
        emit(
          state.copyWith(
            status: GenericStateStatus.error,
            biometricStatus: TransactionBiometricStatus.failed,
            errorMsg: LocaleKeys.transactionBiometricFailed.tr(),
          ),
        );
        return;
      }

      AppLogger().info(
        'Transaction biometric verified '
        '(signature length=${signature.length})',
      );

      emit(
        state.copyWith(biometricStatus: TransactionBiometricStatus.verified),
      );

      await _submitTransaction();
    } catch (e, st) {
      AppLogger().error('Transaction biometric error: $e\n$st');
      emit(
        state.copyWith(
          status: GenericStateStatus.error,
          biometricStatus: TransactionBiometricStatus.failed,
          errorMsg: LocaleKeys.transactionBiometricFailed.tr(),
        ),
      );
    }
  }


  Future<void> _submitTransaction() async {
    try {
      final Result<void, FirebaseException> result = await _repo.addTransaction(
        requestModel: TransactionsModels(
          merchantName: merchantNameController.text.trim(),
          amount: double.parse(amountController.text.trim()),
          category: state.selectedCategory!,
        ),
      );
      result.when(
        (void success) =>
            emit(state.copyWith(status: GenericStateStatus.loaded)),
        (FirebaseException error) => emit(
          state.copyWith(
            status: GenericStateStatus.error,
            errorMsg: error.message.toString(),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      AppLogger().error('Error From Firebase Store  ${e.message}');
      emit(
        state.copyWith(
          status: GenericStateStatus.error,
          errorMsg: e.message.toString(),
        ),
      );
    }
  }

  void selectCategory(TransactionCategory category) {
    emit(
      state.copyWith(
        status: GenericStateStatus.changeUi,
        selectedCategory: category,
      ),
    );
    validateAddTransactionFields();
  }

  void validateAddTransactionFields() {
    final Map<String, String> errors = <String, String>{};

    if (merchantNameController.text.trim().isEmpty) {
      errors['merchantName'] = LocaleKeys.validationMerchantNameRequired.tr();
    }

    if (amountController.text.trim().isEmpty) {
      errors['amount'] = LocaleKeys.validationAmountRequired.tr();
    } else {
      final num? amount = num.tryParse(amountController.text.trim());
      if (amount == null) {
        errors['amount'] = LocaleKeys.validationAmountInvalid.tr();
      } else if (amount <= 0) {
        errors['amount'] = LocaleKeys.validationAmountGreaterThanZero.tr();
      }
    }

    if (state.selectedCategory == null) {
      errors['category'] = LocaleKeys.validationCategoryRequired.tr();
    }

    final bool isValidForm = errors.isEmpty;

    emit(
      state.copyWith(
        status: GenericStateStatus.validationError,
        validationErrors: errors,
        isValidForm: isValidForm,
        selectedCategory: state.selectedCategory,
      ),
    );
  }

  @override
  Future<void> close() {
    merchantNameController.removeListener(validateAddTransactionFields);
    amountController.removeListener(validateAddTransactionFields);
    return super.close();
  }
}
