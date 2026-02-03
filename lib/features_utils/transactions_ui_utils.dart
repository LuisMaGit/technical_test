import 'package:flutter/material.dart';
import 'package:test_doodle/core/models/transactions/transaction_contracts.dart';
import 'package:test_doodle/core_ui/translations.dart';

class TransactionsUIUtils {
  const TransactionsUIUtils._();

  static Map<TransactionIncomeCategory, IconData> incomeCategoryIcons = {
    TransactionIncomeCategory.salary: Icons.work,
    TransactionIncomeCategory.freelance: Icons.laptop,
    TransactionIncomeCategory.investment: Icons.show_chart,
    TransactionIncomeCategory.others: Icons.attach_money,
  };

  static Map<TransactionExpenseCategory, IconData> expenseCategoryIcons = {
    TransactionExpenseCategory.food: Icons.restaurant,
    TransactionExpenseCategory.transport: Icons.directions_car,
    TransactionExpenseCategory.groceries: Icons.local_grocery_store,
    TransactionExpenseCategory.entertainment: Icons.movie,
    TransactionExpenseCategory.utilities: Icons.lightbulb,
    TransactionExpenseCategory.others: Icons.money_off,
  };


  static Map<TransactionIncomeCategory, String> incomeCategoryNames = {
    TransactionIncomeCategory.salary: Translations.salary,
    TransactionIncomeCategory.freelance: Translations.freelance,
    TransactionIncomeCategory.investment: Translations.investment,
    TransactionIncomeCategory.others: Translations.others,
  };

  static Map<TransactionExpenseCategory, String> expenseCategoryNames = {
    TransactionExpenseCategory.food: Translations.food,
    TransactionExpenseCategory.transport: Translations.transport,
    TransactionExpenseCategory.groceries: Translations.groceries,
    TransactionExpenseCategory.entertainment: Translations.entertainment,
    TransactionExpenseCategory.utilities: Translations.utilities,
    TransactionExpenseCategory.others: Translations.others,
  };
}
