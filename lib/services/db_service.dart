import 'package:sqflite/sqflite.dart';

class DbService {
  Database? _db;

  Future<void> open({
    required String dbName,
    required int version,
  }) async {
    final path = await getDatabasesPath();
    _db = await openDatabase(
      '$path/$dbName',
      version: version,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE company (id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
    );
  }

  Future<List<Map>?> rawQuery(
    String sql, {
    List<Object?>? arguments,
  }) async {
    try {
      final results = await _db!.rawQuery(sql, arguments);
      return results;
    } catch (_) {
      return null;
    }
  }

  Future<int?> rawInsert(
    String sql, {
    List<Object?>? arguments,
  }) async {
    try {
      final id = await _db!.rawInsert(sql, arguments);
      if (id == 0) {
        return null;
      }
      return id;
    } catch (_) {
      return null;
    }
  }

  Future<int?> insert(
    String tableName,
    Map<String, dynamic> values,
  ) async {
    try {
      final id = await _db!.insert(tableName, values);
      if (id == 0) {
        return null;
      }
      return id;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> close() async {
    await _db?.close();
  }
}
