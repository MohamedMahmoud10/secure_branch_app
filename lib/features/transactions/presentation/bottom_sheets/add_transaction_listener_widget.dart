import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:secure_branch_app/core/common_widgets/toast_manager.dart';
import 'package:secure_branch_app/features/transactions/presentation/blocs/add_transaction_cubit/add_transaction_cubit.dart';
import 'package:secure_branch_app/generated/locale_keys.g.dart';

class AddTransactionListenerWidget extends StatelessWidget {
  const AddTransactionListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTransactionCubit, AddTransactionState>(
      listener: (BuildContext context, AddTransactionState state) {
        if (state.isLoaded) {
          context.pop();
          ToastManager().success(
            context: context,
            message: LocaleKeys.transactionSuccessMessage.tr(),
            description: LocaleKeys.transactionSuccessDescription.tr(),
          );
        }
        if (state.isError) {
          ToastManager().error(
            context: context,
            message: LocaleKeys.transactionErrorMessage.tr(),
            description: LocaleKeys.transactionErrorDescription.tr(),
          );
        }
      },
      child: child,
    );
  }
}
