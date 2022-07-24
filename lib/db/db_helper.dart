import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'tasks';

  static Future initDb() async {
    if (_db != null) {
      return;
    } else {
      try {
        log('Creating DB');
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
        log(e.toString());
      }
    }
  }

  static Future<int> insert(Task? task) async {
    log('insert');
    return await _db!.insert(_tableName, task!.toMap());
  }

  static Future<List<Map<String, dynamic>>> query() async {
    log("query");
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id= ?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
        UPDATE tasks
        SET isCompleted = ?
        WHERE id = ?
        ''', [1, id]);
  }
}
