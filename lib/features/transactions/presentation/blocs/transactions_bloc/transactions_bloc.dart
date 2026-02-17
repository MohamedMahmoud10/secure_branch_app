import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_branch_app/core/helpers/enums.dart';
import 'package:secure_branch_app/features/transactions/data/models/transactions_models.dart';
import 'package:secure_branch_app/features/transactions/data/repo/user_transactions_repo.dart';

part 'transactions_event.dart';

part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  StreamSubscription<List<TransactionsModels>>? _subscription;
  final UserTransactionsRepo _repo;

  TransactionsBloc(this._repo)
    : super(const TransactionsState(status: GenericStateStatus.initial)) {
    on<FirstTransactionsFetch>(_firstTransactionsFetch);
    on<UpdateTransactions>(_updateTransactions);
    on<TransactionsError>(_errorTransactions);
  }

  Future<void> _firstTransactionsFetch(
      FirstTransactionsFetch event,
      Emitter<TransactionsState> emit,
      ) async {
    await _subscription?.cancel();

    emit(state.copyWith(status: GenericStateStatus.loading));

    try {
      _subscription = _repo.getTransactions().listen(
            (List<TransactionsModels> data) {
          add(UpdateTransactions(responseModel: data));
        },
        onError: (Object error, StackTrace stackTrace) {
          add(
            TransactionsError(
              errorMsg: error.toString(),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GenericStateStatus.error,
          errorMsg: e.toString(),
        ),
      );
    }
  }

  void _updateTransactions(UpdateTransactions event, Emitter<TransactionsState> emit) {
    emit(
      state.copyWith(
        status: GenericStateStatus.loaded,
        responseModel: event.responseModel,
      ),
    );
  }

  void _errorTransactions(TransactionsError event, Emitter<TransactionsState> emit) {
    emit(
      state.copyWith(
        status: GenericStateStatus.error,
        errorMsg: event.errorMsg,
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
