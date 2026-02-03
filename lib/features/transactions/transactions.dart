import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_doodle/core/models/basic_ui_state.dart';
import 'package:test_doodle/core/models/theme_model.dart';
import 'package:test_doodle/core/models/transactions/transaction_contracts.dart';
import 'package:test_doodle/core_ui/components/app_floating_button.dart';
import 'package:test_doodle/core_ui/components/app_icon_button.dart';
import 'package:test_doodle/core_ui/components/app_segmented_button.dart';
import 'package:test_doodle/core_ui/components/app_text.dart';
import 'package:test_doodle/core_ui/components/header.dart';
import 'package:test_doodle/core_ui/components/loader.dart';
import 'package:test_doodle/core_ui/components/transaction_tile.dart';
import 'package:test_doodle/core_ui/theme/theme_constants.dart';
import 'package:test_doodle/core_ui/theme/theme_context.dart';
import 'package:test_doodle/core_ui/translations.dart';
import 'package:test_doodle/features/transactions/transactions_cubit.dart';
import 'package:test_doodle/features_utils/transactions_ui_utils.dart';

part '_components/_list_transactions.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final _transactionCubit = TransactionsCubit();

  @override
  Widget build(BuildContext context) {
    final colors = ThemeContext.of(context).colors;

    Widget floatingButtons() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        spacing: kSize2,
        children: [
          AppFloatingButton(
            heroTag: 'income_button',
            icon: Icons.add,
            onTap: _transactionCubit.onTapAddIncome,
            color: colors.incomeColor,
          ),
          AppFloatingButton(
            heroTag: 'expense_button',
            icon: Icons.remove,
            onTap: _transactionCubit.onTapAddExpense,
            color: colors.expenseColor,
          ),
        ],
      );
    }

    return BlocProvider(
      create: (context) => _transactionCubit..initTransactions(),
      child: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: Header(
              title: Translations.transactionsAppBarTitle,
              actions: [
                AppIconButton(
                  icon: state.themeMode == ThemeModel.light
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  onTap: _transactionCubit.toggleThemeMode,
                ),
              ],
            ),
            floatingActionButton: state.screenState == BasicUIState.success
                ? floatingButtons()
                : null,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
            body: Builder(
              builder: (context) => switch (state.screenState) {
                BasicUIState.loading => Center(child: const Loader()),
                BasicUIState.success => const _Body(),
                BasicUIState.error => const SizedBox(),
              },
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TransactionsCubit>();

    Map<TransactionCategoryType, String> segmentsMap = {
      TransactionCategoryType.all: Translations.all,
      TransactionCategoryType.income: Translations.income,
      TransactionCategoryType.expense: Translations.expense,
    };

    Map<IconData, TransactionCategoryType> iconsMap = {
      Icons.list: TransactionCategoryType.all,
      Icons.arrow_downward: TransactionCategoryType.income,
      Icons.arrow_upward: TransactionCategoryType.expense,
    };

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: kSize1),
          child: AppText.heading(
            '$kTransactionsMoneySymbol${cubit.state.amount}',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kSize1),
          child: AppSegmentedButton(
            icons: iconsMap.keys.toList(),
            segments: segmentsMap.values.toList(),
            selectedIdx: segmentsMap.keys.toList().indexOf(
              cubit.state.categoryType,
            ),
            onSelectionChanged: (selected) {
              final selectedType = segmentsMap.entries
                  .firstWhere((entry) => entry.value == selected)
                  .key;
              cubit.onTapTransactionCategory(selectedType);
            },
          ),
        ),
        Expanded(child: const _ListTransactions()),
      ],
    );
  }
}
