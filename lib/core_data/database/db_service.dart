import 'package:sqflite/sqflite.dart';
import 'package:test_doodle/core/services/time_service/now_provider_service.dart';
import 'package:test_doodle/core_data/database/db_contracts.dart';
import 'package:test_doodle/core_data/database/transaction_db_service/transaction_table_contracts.dart';
import 'package:test_doodle/locator.dart';

class DBService {
  final _nowProviderService = locator<NowProviderService>();

  Database? _database;

  Future<void> _initDB(Database db) async {
    await db.execute(TransactionsTableContracts.createTable());
    await db.execute(
      TransactionsTableContracts.insertSampleData(now: _nowProviderService.now),
    );
  }

  Future<Database> getDB() async {
    _database ??= await openDatabase(
      DBContracts.databaseName,
      version: DBContracts.databaseVersion,
      onCreate: (db, _) => _initDB(db),
    );
    return _database!;
  }
}
