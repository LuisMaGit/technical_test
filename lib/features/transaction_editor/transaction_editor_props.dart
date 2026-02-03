import 'package:equatable/equatable.dart';
import 'package:test_doodle/core/models/transactions/transaction_model.dart';
import 'package:test_doodle/features/transaction_editor/transaction_editor_type.dart';

class TransactionEditorProps extends Equatable {
  const TransactionEditorProps({
    required this.type,
    required this.isExpense,
    this.transaction,
  });
  final TransactionModel? transaction;
  final TransactionEditorType type;
  final bool isExpense;
  
  @override
  List<Object?> get props => [
    transaction,
    type,
    isExpense,
  ];
}
