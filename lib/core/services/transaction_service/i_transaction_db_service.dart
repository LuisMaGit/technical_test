import 'package:test_doodle/core/models/transactions/transaction_model.dart';

abstract class ITransactionDBService {
  Future<List<TransactionModel>> getAllTransactions();
  Future<List<TransactionModel>> getTransactionsByCategory({
    required bool isExpense,
  });
  Future<int> insertTransaction(TransactionModel model);
  Future<double> getTotalAmount();
  Future<int> deleteTransaction(int id);
  Future<void> updateTransaction(TransactionModel model);
}
