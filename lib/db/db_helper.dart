import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'tasks';

  static Future initDb() async {
    if (_db != null) {
    } else {
      try {
        print('Creating DB');
        String _path = await getDatabasesPath() + 'tasks.db';
        _db = await openDatabase(
          _path,
          version: _version,
          onCreate: (db, version) => db.execute("""CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title STRING, note TEXT, date STRING, startTime STRING, endTime STRING,remind INTEGER,
            repeat STRING, color INTEGER, isCompleted INTEGER)"""),
        );
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    print('insert');
    return await _db!.insert(_tableName, task!.toMap());
  }
}
