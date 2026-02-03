import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_doodle/core_ui/components/app_date_picker.dart';
import 'package:test_doodle/core_ui/components/app_dropdown.dart';
import 'package:test_doodle/core_ui/components/app_field.dart';
import 'package:test_doodle/core_ui/components/app_icon_button.dart';
import 'package:test_doodle/core_ui/components/app_primary_button.dart';
import 'package:test_doodle/core_ui/components/header.dart';
import 'package:test_doodle/core_ui/components/loader.dart';
import 'package:test_doodle/core_ui/theme/theme_constants.dart';
import 'package:test_doodle/core_ui/translations.dart';
import 'package:test_doodle/features/transaction_editor/transaction_editor_cubit.dart';
import 'package:test_doodle/features/transaction_editor/transaction_editor_props.dart';
import 'package:test_doodle/features/transaction_editor/transaction_editor_type.dart';
import 'package:test_doodle/features_utils/transactions_ui_utils.dart';

class TransactionEditor extends StatefulWidget {
  const TransactionEditor({required this.props, super.key});

  final TransactionEditorProps props;

  @override
  State<TransactionEditor> createState() => _TransactionEditorState();
}

class _TransactionEditorState extends State<TransactionEditor> {
  final textControllerAmount = TextEditingController();
  final textControllerNote = TextEditingController();
  final focusNodeAmount = FocusNode();
  final focusNodeNote = FocusNode();
  final _transactionCubit = TransactionEditorCubit();

  @override
  void dispose() {
    textControllerAmount.dispose();
    textControllerNote.dispose();
    focusNodeAmount.dispose();
    focusNodeNote.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.props.type == TransactionEditorType.edit;
    final isIncome = !widget.props.isExpense;

    String appBarTitle() {
      if (isEditing) {
        return isIncome
            ? Translations.editIncomeTitle
            : Translations.editExpenseTitle;
      } else {
        return isIncome
            ? Translations.addIncomeTitle
            : Translations.addExpenseTitle;
      }
    }

    List<Widget>? appBarActions() {
      if (isEditing) {
        return [
          AppIconButton(
            icon: Icons.delete,
            onTap: _transactionCubit.onTapDelete,
          ),
        ];
      }
      return null;
    }

    return BlocProvider(
      create: (context) => _transactionCubit
        ..init(
          props: widget.props,
          setAmount: (text) => textControllerAmount.text = text,
          setNote: (text) => textControllerNote.text = text,
          unfocusAll: () => {
            focusNodeAmount.unfocus(),
            focusNodeNote.unfocus(),
          },
        ),
      child: BlocBuilder<TransactionEditorCubit, TransactionEditorState>(
        builder: (context, state) {
          return Scaffold(
            appBar: Header(
              title: appBarTitle(),
              actions: appBarActions(),
              withLeading: true,
            ),
            body: state.uiState == .success
                ? _Body(
                    focusNodeAmount: focusNodeAmount,
                    focusNodeNote: focusNodeNote,
                    textControllerAmount: textControllerAmount,
                    textControllerNote: textControllerNote,
                  )
                : const Loader(),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.focusNodeAmount,
    required this.focusNodeNote,
    required this.textControllerAmount,
    required this.textControllerNote,
  });

  final TextEditingController textControllerAmount;
  final TextEditingController textControllerNote;
  final FocusNode focusNodeAmount;
  final FocusNode focusNodeNote;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TransactionEditorCubit>();
    const space = SizedBox(height: kSize2);

    List<String> drops() {
      if (cubit.state.isExpense) {
        return TransactionsUIUtils.expenseCategoryNames.values.toList();
      } else {
        return TransactionsUIUtils.incomeCategoryNames.values.toList();
      }
    }

    List<IconData> dropIcons() {
      if (cubit.state.isExpense) {
        return TransactionsUIUtils.expenseCategoryIcons.values.toList();
      } else {
        return TransactionsUIUtils.incomeCategoryIcons.values.toList();
      }
    }

    int dropSelectedIdx() {
      if (cubit.state.isExpense) {
        return TransactionsUIUtils.expenseCategoryNames.keys.toList().indexOf(
          cubit.state.transaction.expenseCategory,
        );
      } else {
        return TransactionsUIUtils.incomeCategoryNames.keys.toList().indexOf(
          cubit.state.transaction.incomeCategory,
        );
      }
    }

    void onDropSelectionChanged(String value) {
      if (cubit.state.isExpense) {
        final selectedCategory = TransactionsUIUtils
            .expenseCategoryNames
            .entries
            .firstWhere((entry) => entry.value == value)
            .key;
        cubit.onChangeExpenseCategory(selectedCategory);
      } else {
        final selectedCategory = TransactionsUIUtils.incomeCategoryNames.entries
            .firstWhere((entry) => entry.value == value)
            .key;
        cubit.onChangeIncomeCategory(selectedCategory);
      }
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: kSize2),
              children: [
                space,
                AppField(
                  textController: textControllerAmount,
                  focusNode: focusNodeAmount,
                  label: Translations.amount,
                  keyboardType: .numberWithOptions(decimal: true),
                  disabled: cubit.state.sendingData,
                  inputFormatters: [MoneyInputFormatter()],
                  onChanged: cubit.onChangeAmount,
                  error: cubit.state.showValidationsErrors
                      ? Translations.amountValidationError
                      : null,
                ),
                space,
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    AppDropDown(
                      label: Translations.category,
                      drops: drops(),
                      icons: dropIcons(),
                      selectedIdx: dropSelectedIdx(),
                      onSelectionChanged: onDropSelectionChanged,
                      disabled: cubit.state.sendingData,
                    ),
                    AppDatePicker(
                      label: Translations.date,
                      initialDate:
                          cubit.state.transaction.date!,
                      firstDate: cubit.state.firstDate!,
                      lastDate: cubit.state.lastDate!,
                      onSelect: cubit.onChangeDate,
                      disabled: cubit.state.sendingData,
                    ),
                  ],
                ),
                space,
                AppField(
                  textController: textControllerNote,
                  focusNode: focusNodeNote,
                  label: Translations.note,
                  maxLines: 4,
                  disabled: cubit.state.sendingData,
                  keyboardType: .multiline,
                  onChanged: cubit.onChangeNote,
                ),
                space,
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kSize2,
              vertical: kSize1,
            ),
            width: double.infinity,
            child: AppPrimaryButton(
              title: Translations.save,
              onTap: cubit.submit,
              disabled: cubit.state.sendingData,
            ),
          ),
        ],
      ),
    );
  }
}
