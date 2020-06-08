import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/todo_model.dart';

class DatabaseHelper {
  static final _databaseName = "todo_list.db";
  static final _databaseVersion = 1;

  static final table = 'todo_list';

  static final columnId = 'id';
  static final columnDetails = 'title';
  static final columnDate = 'description';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnDetails TEXT NOT NULL,
            $columnDate TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Todo item) async {
    Database db = await instance.database;
    return await db.insert(table, item.toMap());
  }

  Future<List<Todo>> queryAllRows() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query(table);
    List<Todo> todo = List<Todo>();

    data.forEach((element) {
      todo.add(Todo.fromMap(element));
    });

    return todo;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> closeDatabase() {
    if (_database != null) {
      return _database.close();
    }

    return null;
  }
}
