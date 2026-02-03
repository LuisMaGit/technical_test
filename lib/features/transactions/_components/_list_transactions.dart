part of '../transactions.dart';

class _ListTransactions extends StatelessWidget {
  const _ListTransactions();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TransactionsCubit>();
    final transactions = cubit.state.transactions;

    if (transactions.isEmpty) {
      return Align(
        alignment: Alignment.topCenter,
        child: AppText.body(
          Translations.noTransactionsAvailable,
          align: .center,
        ),
      );
    }
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];

        String categoryText() {
          return (transaction.isExpense
                  ? TransactionsUIUtils.expenseCategoryNames[transaction
                        .expenseCategory]
                  : TransactionsUIUtils.incomeCategoryNames[transaction
                        .incomeCategory]) ??
              '';
        }

        IconData icon() {
          return (transaction.isExpense
                  ? TransactionsUIUtils.expenseCategoryIcons[transaction
                        .expenseCategory]
                  : TransactionsUIUtils.incomeCategoryIcons[transaction
                        .incomeCategory]) ??
              Icons.money_off;
        }

        return TransactionTile(
          category: categoryText(),
          onTap: () => cubit.onTapTransaction(transaction.id),
          description: transaction.note,
          amount: transaction.amount,
          date: transaction.date ?? DateTime(0),
          icon: icon(),
          isExpense: transaction.isExpense,
        );
      },
    );
  }
}
