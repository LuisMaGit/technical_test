import 'package:test_doodle/core/models/transactions/transaction_contracts.dart';
import 'package:test_doodle/core/models/transactions/transaction_model.dart';
import 'package:test_doodle/core_data/database/transaction_db_service/transaction_table_contracts.dart';

class TransactionEntity {
  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.date,
    required this.isExpense,
    required this.category,
    this.note,
  });

  factory TransactionEntity.fromMap(Map<String, dynamic> map) {
    return TransactionEntity(
      id: map[TransactionsTableContracts.columnId],
      amount: map[TransactionsTableContracts.columnAmount],
      date: map[TransactionsTableContracts.columnDate],
      category: map[TransactionsTableContracts.columnCategory],
      isExpense: map[TransactionsTableContracts.columnIsExpense],
      note: map[TransactionsTableContracts.columnNote],
    );
  }

  factory TransactionEntity.fromModel({
    required TransactionModel model,
    required String Function(DateTime date) dateTimeFormatter,
  }) {
    return TransactionEntity(
      id: model.id,
      amount: model.amount,
      date: dateTimeFormatter(model.date!),
      category: model.isExpense
          ? model.expenseCategory.source
          : model.incomeCategory.source,
      isExpense: model.isExpense ? 1 : 0,
      note: model.note,
    );
  }

  final int id;
  final double amount;
  final String date;
  final String category;
  final int isExpense;
  final String? note;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TransactionsTableContracts.columnId: id,
      TransactionsTableContracts.columnAmount: amount,
      TransactionsTableContracts.columnCategory: category,
      TransactionsTableContracts.columnDate: date,
      TransactionsTableContracts.columnIsExpense: isExpense,
      TransactionsTableContracts.columnNote: note,
    };
  }

  Map<String, dynamic> toMapInsert() {
    return <String, dynamic>{
      TransactionsTableContracts.columnAmount: amount,
      TransactionsTableContracts.columnCategory: category,
      TransactionsTableContracts.columnDate: date,
      TransactionsTableContracts.columnIsExpense: isExpense,
      TransactionsTableContracts.columnNote: note,
    };
  }

  TransactionModel toModel({
    required DateTime Function(String date) dateTimeParser,
  }) {
    return TransactionModel(
      id: id,
      amount: amount,
      note: note ?? '',
      expenseCategory: TransactionExpenseCategory.fromSource(category),
      incomeCategory: TransactionIncomeCategory.fromSource(category),
      date: dateTimeParser(date),
      isExpense: isExpense == 1,
    );
  }
}
