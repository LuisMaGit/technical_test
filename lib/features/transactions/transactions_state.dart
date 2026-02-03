part of 'transactions_cubit.dart';

enum TransactionCategoryType { all, expense, income }

class TransactionsState extends Equatable {
  const TransactionsState({
    this.transactions = const [],
    this.screenState = BasicUIState.loading,
    this.amount = 0,
    this.categoryType = TransactionCategoryType.all,
    this.themeMode = .light,
  });

  final List<TransactionModel> transactions;
  final BasicUIState screenState;
  final double amount;
  final TransactionCategoryType categoryType;
  final ThemeModel themeMode;

  @override
  List<Object> get props => [transactions, screenState, categoryType, themeMode];

  TransactionsState copyWith({
    List<TransactionModel>? transactions,
    BasicUIState? screenState,
    double? amount,
    TransactionCategoryType? categoryType,
    ThemeModel? themeMode,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      screenState: screenState ?? this.screenState,
      amount: amount ?? this.amount,
      categoryType: categoryType ?? this.categoryType,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
