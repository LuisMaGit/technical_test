import 'package:flutter/material.dart';
import 'package:test_doodle/core/models/transactions/transaction_contracts.dart';
import 'package:test_doodle/core_ui/components/app_icon.dart';
import 'package:test_doodle/core_ui/components/app_text.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';
import 'package:test_doodle/core_ui/translations.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    required this.icon,
    required this.isExpense,
    required this.onTap,
    super.key,
  });

  final String category;
  final String description;
  final double amount;
  final DateTime date;
  final IconData icon;
  final bool isExpense;
  final VoidCallback onTap;

  static const titleSize = 24.0;

  @override
  Widget build(BuildContext context) {
    final colors = ThemeContext.of(context).colors;

    String buildAmountText() {
      if (!isExpense) {
        return '+$amount$kTransactionsMoneySymbol';
      }

      return '$amount$kTransactionsMoneySymbol';
    }

    final colorCategory = isExpense ? colors.expenseColor : colors.incomeColor;

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: colorCategory.withValues(alpha: 0.7),
        child: AppIcon(icon: icon),
      ),
      title: AppText.heading(category, fontSize: titleSize),
      subtitle: AppText.caption(Translations.dateText(date), maxLines: 2),
      trailing: AppText.body(buildAmountText(), color: colorCategory),
    );
  }
}
