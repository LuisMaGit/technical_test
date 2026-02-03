import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_doodle/core/models/basic_ui_state.dart';
import 'package:test_doodle/core/models/theme_model.dart';
import 'package:test_doodle/core/models/transactions/transaction_model.dart';
import 'package:test_doodle/core/services/theme_service.dart';
import 'package:test_doodle/core/services/transaction_service/i_transaction_db_service.dart';
import 'package:test_doodle/features/transaction_editor/transaction_editor_props.dart';
import 'package:test_doodle/locator.dart';
import 'package:test_doodle/router/navigator_service.dart';
import 'package:test_doodle/router/routes.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit() : super(const TransactionsState());

  final _transactionsDBService = locator<ITransactionDBService>();
  final _themeService = locator<ThemeService>();
  final _navigationService = locator<NavigatorService>();

  Future<void> _listenToThemeChanges() async {
    _themeService.themeStream.listen((themeMode) {
      emit(state.copyWith(themeMode: themeMode));
    });
  }

  Future<void> _getTransactions({
    required bool setLoadingState,
    required TransactionCategoryType categoryType,
  }) async {
    if (setLoadingState) {
      emit(state.copyWith(screenState: BasicUIState.loading));
    }

    final futures = [
      switch (categoryType) {
        TransactionCategoryType.all =>
          _transactionsDBService.getAllTransactions(),
        TransactionCategoryType.expense =>
          _transactionsDBService.getTransactionsByCategory(isExpense: true),
        TransactionCategoryType.income =>
          _transactionsDBService.getTransactionsByCategory(isExpense: false),
      },
      _transactionsDBService.getTotalAmount(),
    ];

    final responses = await Future.wait(futures);
    final transactions = responses[0] as List<TransactionModel>;
    final amount = responses[1] as double;

    emit(
      state.copyWith(
        transactions: transactions,
        amount: amount,
        categoryType: categoryType,
        screenState: BasicUIState.success,
      ),
    );
  }

  // Events
  Future<void> initTransactions() async {
    _listenToThemeChanges();
    await _getTransactions(
      setLoadingState: false,
      categoryType: state.categoryType,
    );
  }

  Future<void> onTapTransactionCategory(
    TransactionCategoryType category,
  ) async {
    if (category == state.categoryType) {
      return;
    }

    await _getTransactions(setLoadingState: true, categoryType: category);
  }

  Future<void> toggleThemeMode() async {
    await _themeService.changeTheme(
      state.themeMode == ThemeModel.light ? ThemeModel.dark : ThemeModel.light,
    );
  }

  Future<void> onTapAddExpense() async {
    await _navigationService.goTo(
      Routes.transactionEditor,
      arguments: TransactionEditorProps(type: .create, isExpense: true),
    );
    await _getTransactions(
      setLoadingState: true,
      categoryType: state.categoryType,
    );
  }

  Future<void> onTapAddIncome() async {
    await _navigationService.goTo(
      Routes.transactionEditor,
      arguments: TransactionEditorProps(type: .create, isExpense: false),
    );
    await _getTransactions(
      setLoadingState: true,
      categoryType: state.categoryType,
    );
  }

  Future<void> onTapTransaction(int transactionId) async {
    final transaction = state.transactions.firstWhere(
      (tx) => tx.id == transactionId,
    );
    await _navigationService.goTo(
      Routes.transactionEditor,
      arguments: TransactionEditorProps(
        type: .edit,
        isExpense: transaction.isExpense,
        transaction: transaction,
      ),
    );
    await _getTransactions(
      setLoadingState: true,
      categoryType: state.categoryType,
    );
  }
}
