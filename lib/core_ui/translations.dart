class Translations {
  const Translations._();

  static const String transactionsAppBarTitle = 'Your balance is';
  static const String noTransactionsAvailable = 'No transactions available';
  static const String all = 'All';
  static const String income = 'Income';
  static const String expense = 'Expense';
  static const String addIncomeTitle = 'Add Income';
  static const String addExpenseTitle = 'Add Expense';
  static const String editIncomeTitle = 'Edit Income';
  static const String editExpenseTitle = 'Edit Expense';
  static const String save = 'Save';
  static const String amount = 'Amount';
  static const String note = 'Note';
  static const String category = 'Category';
  static const String date = 'Date';
  static const String amountValidationError = 'Amount must be greater than zero';

  static  String dateText(DateTime date) => '${date.day}/${date.month}/${date.year}';
  static const String salary = 'Salary';
  static const String freelance = 'Freelance';
  static const String investment = 'Investment';
  static const String food = 'Food';
  static const String transport = 'Transport';
  static const String groceries = 'Groceries';  
  static const String entertainment = 'Entertainment';
  static const String utilities = 'Utilities';
  static const String others = 'Others';
}