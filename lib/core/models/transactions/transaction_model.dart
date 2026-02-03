import 'package:equatable/equatable.dart';

import 'package:test_doodle/core/models/transactions/transaction_contracts.dart';

class TransactionModel extends Equatable {
  const TransactionModel({
    this.id = 0,
    this.amount = 0,
    this.note = '',
    this.expenseCategory = .others,
    this.incomeCategory = .others,
    this.date,
    this.isExpense = false,
  });

  final int id;
  final double amount;
  final String note;
  final TransactionExpenseCategory expenseCategory;
  final TransactionIncomeCategory incomeCategory;
  final DateTime? date;
  final bool isExpense;

  @override
  List<Object?> get props => [
    id,
    amount,
    note,
    expenseCategory,
    incomeCategory,
    date,
    isExpense,
  ];

  TransactionModel copyWith({
    int? id,
    double? amount,
    String? note,
    TransactionExpenseCategory? expenseCategory,
    TransactionIncomeCategory? incomeCategory,
    DateTime? date,
    bool? isExpense,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      expenseCategory: expenseCategory ?? this.expenseCategory,
      incomeCategory: incomeCategory ?? this.incomeCategory,
      date: date ?? this.date,
      isExpense: isExpense ?? this.isExpense,
    );
  }
}
