import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secure_branch_app/config/theme/app_colors.dart';
import 'package:secure_branch_app/core/common_widgets/custom_loading_button.dart';
import 'package:secure_branch_app/core/common_widgets/custom_text_form_field.dart';
import 'package:secure_branch_app/core/common_widgets/toast_manager.dart';
import 'package:secure_branch_app/core/extensions/color_extension.dart';
import 'package:secure_branch_app/core/extensions/transaction_category_extension.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/features/transactions/presentation/blocs/add_transaction_cubit/add_transaction_cubit.dart';
import 'package:secure_branch_app/features/transactions/presentation/bottom_sheets/add_transaction_listener_widget.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class AddTransactionBottomSheet extends StatelessWidget {
  const AddTransactionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final AddTransactionCubit cubit = context.read<AddTransactionCubit>();
    final Map<String, String>? validationErrors = context
        .watch<AddTransactionCubit>()
        .state
        .validationErrors;

    return Container(
      padding: EdgeInsets.all(
        24.w,
      ).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValueOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: AddTransactionListenerWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: 50.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            Text(
              LocaleKeys.newTransaction.tr(),
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
            Text(
              LocaleKeys.recordSecureLedgerEntry.tr(),
              style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
            ),
            SizedBox(height: 24.h),

            CustomTextFormField(
              hintText: LocaleKeys.merchantRecipient.tr(),
              prefixIcon: const Icon(Icons.storefront_outlined),
              textEditingController: cubit.merchantNameController,
              keyboardType: TextInputType.name,
              keyboardAction: TextInputAction.next,

            ),
            SizedBox(height: 16.h),

            CustomTextFormField(
              hintText: LocaleKeys.amount.tr(),
              prefixIcon: const Icon(Icons.attach_money_rounded),
              textEditingController: cubit.amountController,
              keyboardType: TextInputType.number,
              keyboardAction: TextInputAction.done,

            ),

            SizedBox(height: 16.h),

            Text(
              LocaleKeys.transactionCategory.tr(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            BlocBuilder<AddTransactionCubit, AddTransactionState>(
              builder: (BuildContext context, AddTransactionState state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: TransactionCategory.values.map((
                    TransactionCategory category,
                  ) {
                    final bool isSelected = state.selectedCategory == category;
                    return GestureDetector(
                      onTap: () => cubit.selectCategory(category),
                      child: Column(
                        children: <Widget>[
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.background,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.accent
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Icon(
                                category.icon,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.primary,
                              ),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            category.translationKey,
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.biometric.withValueOpacity(0.08),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.biometric.withValueOpacity(0.2),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.fingerprint,
                    color: AppColors.biometric,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      LocaleKeys.transactionBiometricNotice.tr(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.biometric,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            CustomLoadingButton<AddTransactionCubit, AddTransactionState>(
              onTap: cubit.addTransaction,
              cubit: cubit,
              loadingState: const AddTransactionState(
                status: GenericStateStatus.loading,
              ),
              backGroundColor: AppColors.primary,
              isClickable: context.select<AddTransactionCubit, bool>(
                (AddTransactionCubit cubit) => cubit.state.isValidForm!,
              ),
              errorCallBack: () {
                final String errorMessage = validationErrors != null
                    ? validationErrors.values.first
                    : LocaleKeys.validationGenericError.tr();

                ToastManager().error(
                  context: context,
                  description: errorMessage,
                  message: LocaleKeys.validationGenericError.tr(),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.fingerprint, color: Colors.white, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    LocaleKeys.verifyAndSubmit.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
