part of 'transaction_editor_cubit.dart';

class TransactionEditorState extends Equatable {
  const TransactionEditorState({
    this.transaction = const TransactionModel(),
    this.type = TransactionEditorType.create,
    this.isExpense = false,
    this.sendingData = false,
    this.showValidationsErrors = false,
    this.uiState = .loading,
    this.firstDate,
    this.lastDate,
  });

  final TransactionModel transaction;
  final TransactionEditorType type;
  final bool isExpense;
  final bool sendingData;
  final bool showValidationsErrors;
  final BasicUIState uiState;
  final DateTime? firstDate;
  final DateTime? lastDate;
  
  @override
  List<Object?> get props => [
    transaction,
    type,
    isExpense,
    sendingData,
    showValidationsErrors,
    uiState,
    firstDate,
    lastDate,
  ];


  TransactionEditorState copyWith({
    TransactionModel? transaction,
    TransactionEditorType? type,
    bool? isExpense,
    bool? sendingData,
    bool? showValidationsErrors,
    BasicUIState? uiState,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return TransactionEditorState(
      transaction: transaction ?? this.transaction,
      type: type ?? this.type,
      isExpense: isExpense ?? this.isExpense,
      sendingData: sendingData ?? this.sendingData,
      showValidationsErrors: showValidationsErrors ?? this.showValidationsErrors,
      uiState: uiState ?? this.uiState,
      firstDate: firstDate ?? this.firstDate,
      lastDate: lastDate ?? this.lastDate,
    );
  }
}
