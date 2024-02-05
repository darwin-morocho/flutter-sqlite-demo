import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService(this._database);

  final Database _database;

  static Future<DatabaseService> open(String databaseName, int version) async {
    final databasesPath = await getDatabasesPath();

    final database = await openDatabase(
      join(databasesPath, databaseName),
      version: version,
      onCreate: (db, version) async {
        await db.execute(
          '''
CREATE TABLE company (id INTEGER PRIMARY KEY, name TEXT)
''',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1) {
          await db.execute(
            'ALTER TABLE company ADD description TEXT',
          );
        }
      },
    );
    return DatabaseService(database);
  }

  Future<List<Map>> rawQuery(
    String sql, {
    List<Object?>? arguments,
  }) {
    return _database.rawQuery(sql, arguments);
  }

  Future<bool> rawDelete(
    String sql, {
    List<Object?>? arguments,
  }) async {
    try {
      await _database.rawDelete(sql, arguments);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<int?> rawInsert(
    String sql, {
    List<Object?>? arguments,
  }) async {
    try {
      final id = await _database.rawInsert(sql, arguments);
      return id != 0 ? id : null;
    } catch (_) {
      return null;
    }
  }

  Future<List<T>?> insertAll<T>(
    String tableName,
    List<InsertRecord> records,
  ) async {
    try {
      final list = await _database.transaction<List<T>>(
        (txn) async {
          final data = <T>[];
          for (final record in records) {
            final id = await txn.insert(tableName, record.values);
            data.add(record.parser(id));
          }
          return data;
        },
      );
      return list;
    } catch (_) {
      return null;
    }
  }

  Future<void> close() async {
    await _database.close();
  }
}

class InsertRecord<T> {
  InsertRecord(this.values, this.parser);

  final Map<String, Object?> values;
  final T Function(int id) parser;
}
