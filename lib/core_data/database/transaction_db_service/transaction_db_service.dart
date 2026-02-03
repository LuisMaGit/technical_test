import 'package:test_doodle/core/models/transactions/transaction_model.dart';
import 'package:test_doodle/core/services/time_service/time_service.dart';
import 'package:test_doodle/core/services/transaction_service/i_transaction_db_service.dart';
import 'package:test_doodle/core_data/database/db_service.dart';
import 'package:test_doodle/core_data/database/entities/transaction_entity.dart';
import 'package:test_doodle/core_data/database/transaction_db_service/transaction_table_contracts.dart';
import 'package:test_doodle/locator.dart';

class TransactionDbService implements ITransactionDBService {
  final _dbProviderService = locator<DBService>();
  final _timeService = locator<TimeService>();

  List<String> _allColumns() => [
    TransactionsTableContracts.columnId,
    TransactionsTableContracts.columnCategory,
    TransactionsTableContracts.columnAmount,
    TransactionsTableContracts.columnNote,
    TransactionsTableContracts.columnDate,
    TransactionsTableContracts.columnIsExpense,
  ];

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await _dbProviderService.getDB();
    final maps = await db.query(
      TransactionsTableContracts.tableName,
      columns: _allColumns(),
      orderBy: '${TransactionsTableContracts.columnDate} DESC',
    );

    if (maps.isNotEmpty) {
      final entities = maps
          .map((map) => TransactionEntity.fromMap(map))
          .toList();
      return entities
          .map(
            (entity) => entity.toModel(
              dateTimeParser: (date) {
                return _timeService.parse(date);
              },
            ),
          )
          .toList();
    }

    return [];
  }

  @override
  Future<List<TransactionModel>> getTransactionsByCategory({
    required bool isExpense,
  }) async {
    final db = await _dbProviderService.getDB();
    final maps = await db.query(
      TransactionsTableContracts.tableName,
      columns: _allColumns(),
      where: '${TransactionsTableContracts.columnIsExpense} = ?',
      whereArgs: [isExpense ? 1 : 0],
      orderBy: '${TransactionsTableContracts.columnDate} DESC',
    );

    if (maps.isNotEmpty) {
      final entities = maps
          .map((map) => TransactionEntity.fromMap(map))
          .toList();
      return entities
          .map(
            (entity) => entity.toModel(
              dateTimeParser: (date) => _timeService.parse(date),
            ),
          )
          .toList();
    }

    return [];
  }

  @override
  Future<int> insertTransaction(TransactionModel model) async {
    final db = await _dbProviderService.getDB();
    final entity = TransactionEntity.fromModel(
      model: model,
      dateTimeFormatter: (date) => _timeService.format(date),
    );
    return db.insert(
      TransactionsTableContracts.tableName,
      entity.toMapInsert(),
    );
  }

  @override
  Future<double> getTotalAmount() async {
    final db = await _dbProviderService.getDB();
    final result = await db.rawQuery(
      TransactionsTableContracts.totalAmountQuery(),
    );
    final total =
        result.first[TransactionsTableContracts.columnTotalAmount] as double?;
    return total ?? 0.0;
  }

  @override
  Future<int> deleteTransaction(int id) async {
    final db = await _dbProviderService.getDB();
    return await db.delete(
      TransactionsTableContracts.tableName,
      where: '${TransactionsTableContracts.columnId} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updateTransaction(TransactionModel model) async {
    final db = await _dbProviderService.getDB();
    final entity = TransactionEntity.fromModel(
      model: model,
      dateTimeFormatter: (date) => _timeService.format(date),
    );
    await db.update(
      TransactionsTableContracts.tableName,
      entity.toMap(),
      where: '${TransactionsTableContracts.columnId} = ?',
      whereArgs: [model.id],
    );
  }
}
