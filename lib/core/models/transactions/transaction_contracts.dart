// Ideally all this contracts should be in the database
// but, for the sake of simplicity and demonstration, they are defined here.

enum TransactionIncomeCategory {
  salary('salary'),
  freelance('freelance'),
  investment('investment'),
  others('others');

  const TransactionIncomeCategory(this.source);
  final String source;

  static TransactionIncomeCategory fromSource(String source) {
    for (var category in TransactionIncomeCategory.values) {
      if (category.source == source) {
        return category;
      }
    }
    return TransactionIncomeCategory.others;
  }
}

enum TransactionExpenseCategory {
  food('food'),
  transport('transport'),
  groceries('groceries'),
  entertainment('entertainment'),
  utilities('utilities'),
  others('others');

  const TransactionExpenseCategory(this.source);
  final String source;

  static TransactionExpenseCategory fromSource(String source) {
    for (var category in TransactionExpenseCategory.values) {
      if (category.source == source) {
        return category;
      }
    }
    return TransactionExpenseCategory.others;
  }
}

const kTransactionsMoneySymbol = '\$';
const kTransactionsDateYearInThePast = 2;

