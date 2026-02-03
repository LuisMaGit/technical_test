import 'package:test_doodle/core/models/transactions/transaction_contracts.dart';
import 'package:test_doodle/core/extensions/number_extensions.dart';

class TransactionsTableContracts {
  const TransactionsTableContracts._();

  static const tableName = 'transactions_manager';
  static const columnId = 'id';
  static const columnCategory = 'category';
  static const columnAmount = 'amount';
  static const columnNote = 'note';
  static const columnDate = 'date';
  static const columnIsExpense = 'is_expense';

  static const columnTotalAmount = 'total';

  static String createTable() {
    return '''
      CREATE TABLE IF NOT EXISTS ${TransactionsTableContracts.tableName} (
        ${TransactionsTableContracts.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TransactionsTableContracts.columnCategory} TEXT NOT NULL,
        ${TransactionsTableContracts.columnAmount} REAL NOT NULL,
        ${TransactionsTableContracts.columnNote} TEXT,
        ${TransactionsTableContracts.columnDate} TEXT NOT NULL,
        ${TransactionsTableContracts.columnIsExpense} INTEGER NOT NULL
      )
    ''';
  }

  static String totalAmountQuery() {
    return '''
      SELECT SUM(${TransactionsTableContracts.columnAmount}) as ${TransactionsTableContracts.columnTotalAmount} 
      FROM ${TransactionsTableContracts.tableName}
    ''';
  }

  static String insertSampleData({required DateTime now}) {
    return '''
      INSERT INTO ${TransactionsTableContracts.tableName} 
      (${TransactionsTableContracts.columnCategory}, ${TransactionsTableContracts.columnAmount}, ${TransactionsTableContracts.columnNote}, ${TransactionsTableContracts.columnDate}, ${TransactionsTableContracts.columnIsExpense}) 
      VALUES 
      ('${TransactionExpenseCategory.food.source}', -15.50, 'Lunch at cafe', '${now.year}-${now.month.putZeroInSingleDigit()}-01', 1),
      ('${TransactionIncomeCategory.salary.source}', 1500.00, 'Monthly salary', '${now.year}-${now.month.putZeroInSingleDigit()}-01', 0),
      ('${TransactionExpenseCategory.transport.source}', -2.75, 'Bus ticket', '${now.year}-${now.month.putZeroInSingleDigit()}-02', 1),
      ('${TransactionExpenseCategory.groceries.source}', -45.20, 'Weekly groceries', '${now.year}-${now.month.putZeroInSingleDigit()}-03', 1),
      ('${TransactionIncomeCategory.freelance.source}', 300.00, 'Project payment', '${now.year}-${now.month.putZeroInSingleDigit()}-04', 0)
    ''';
  }
}
