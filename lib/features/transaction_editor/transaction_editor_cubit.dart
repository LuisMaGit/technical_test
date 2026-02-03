import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_doodle/core/models/basic_ui_state.dart';
import 'package:test_doodle/core/models/transactions/transaction_contracts.dart';
import 'package:test_doodle/core/models/transactions/transaction_model.dart';
import 'package:test_doodle/core/services/time_service/now_provider_service.dart';
import 'package:test_doodle/core/services/time_service/time_service.dart';
import 'package:test_doodle/core/services/transaction_service/i_transaction_db_service.dart';
import 'package:test_doodle/features/transaction_editor/transaction_editor_props.dart';
import 'package:test_doodle/features/transaction_editor/transaction_editor_type.dart';
import 'package:test_doodle/locator.dart';
import 'package:test_doodle/router/navigator_service.dart';

part 'transaction_editor_state.dart';

class TransactionEditorCubit extends Cubit<TransactionEditorState> {
  TransactionEditorCubit() : super(const TransactionEditorState());

  final _navigatorService = locator<NavigatorService>();
  final _transactionDBService = locator<ITransactionDBService>();
  final _nowProviderService = locator<NowProviderService>();
  final _timeService = locator<TimeService>();

  late void Function(String) _setAmount;
  late void Function(String) _setNote;
  late void Function() _unfocusAll;

  Future<void> _submitCreation() async {
    emit(state.copyWith(sendingData: true));
    final transactionToSave = state.transaction.copyWith(
      isExpense: state.isExpense,
      amount: state.isExpense
          ? -state.transaction.amount
          : state.transaction.amount,
    );
    await _transactionDBService.insertTransaction(transactionToSave);
    _navigatorService.goBack();
  }

  Future<void> _submitEdit() async {
    emit(state.copyWith(sendingData: true));
    final transactionToSave = state.transaction.copyWith(
      isExpense: state.isExpense,
      amount: state.isExpense
          ? -state.transaction.amount.abs()
          : state.transaction.amount.abs(),
    );
    await _transactionDBService.updateTransaction(transactionToSave);
    _navigatorService.goBack();
  }

  void _initForms(TransactionEditorProps props) {
    if (props.type == .create) {
      return;
    }

    if (props.transaction?.amount != 0) {
      _setAmount(props.transaction!.amount.toString());
    }
    if (props.transaction?.note.isNotEmpty ?? false) {
      _setNote(props.transaction!.note.toString());
    }
  }

  // events
  void init({
    required TransactionEditorProps props,
    required Function(String) setAmount,
    required Function(String) setNote,
    required Function() unfocusAll,
  }) {
    _setAmount = setAmount;
    _setNote = setNote;
    _unfocusAll = unfocusAll;

    _initForms(props);
    final now = _nowProviderService.now;
    emit(
      state.copyWith(
        transaction: props.type == .create
            ? TransactionModel(date: now)
            : props.transaction,
        isExpense: props.isExpense,
        firstDate: _timeService.addYears(now, -2), // can select up to 2 years back
        lastDate: now,
        type: props.type,
        uiState: .success,
      ),
    );
  }

  Future<void> onTapDelete() async {
    emit(state.copyWith(sendingData: true));
    await _transactionDBService.deleteTransaction(state.transaction.id);
    _navigatorService.goBack();
  }

  void onChangeAmount(String amountStr) {
    final amount = double.tryParse(amountStr) ?? 0;
    emit(
      state.copyWith(
        transaction: state.transaction.copyWith(amount: amount),
        showValidationsErrors: false,
      ),
    );
  }

  void onChangeNote(String note) {
    emit(state.copyWith(transaction: state.transaction.copyWith(note: note)));
  }

  void onChangeExpenseCategory(TransactionExpenseCategory category) {
    _unfocusAll();
    emit(
      state.copyWith(
        transaction: state.transaction.copyWith(expenseCategory: category),
      ),
    );
  }

  void onChangeIncomeCategory(TransactionIncomeCategory category) {
    _unfocusAll();
    emit(
      state.copyWith(
        transaction: state.transaction.copyWith(incomeCategory: category),
      ),
    );
  }

  void onChangeDate(DateTime date) {
    _unfocusAll();
    emit(state.copyWith(transaction: state.transaction.copyWith(date: date)));
  }

  Future<void> submit() async {
    if (state.transaction.amount == 0) {
      emit(state.copyWith(showValidationsErrors: true));
      return;
    }

    if (state.type == .create) {
      await _submitCreation();
      return;
    }

    await _submitEdit();
  }
}
