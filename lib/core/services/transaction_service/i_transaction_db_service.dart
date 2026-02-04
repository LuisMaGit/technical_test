import 'package:test_doodle/core/models/transactions/transaction_model.dart';

abstract class ITransactionDBService {
  Future<List<TransactionModel>> getAllTransactions();
  Future<List<TransactionModel>> getTransactionsByCategory({
    required bool isExpense,
  });
  Future<bool> insertTransaction(TransactionModel model);
  Future<double> getTotalAmount();
  Future<bool> deleteTransaction(int id);
  Future<bool> updateTransaction(TransactionModel model);
}
