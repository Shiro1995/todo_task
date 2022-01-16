import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_task/models/task_model.dart';

const String DB_NAME = "task_database.db";
const String TABLE_TASK = "task";

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider._();
  Database? _database;

  DatabaseProvider._();

  Future<Database> get database async {
    return await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: 1,
      onCreate: (db, version) {
        return db.execute("""CREATE TABLE $TABLE_TASK (
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            status INTEGER
        )""");
      },
    );
  }

  Future close() {
    return _database!.close();
  }

  //delete the database
  Future deleteDB() async {
    return deleteDatabase(join(await getDatabasesPath(), DB_NAME));
  }

  Future<bool> addTask(TaskModel task) async {
    final db = await database;
    final result = await db.insert(TABLE_TASK, task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return result >= 0;
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(TABLE_TASK);
    if (maps.isEmpty) return [];
    List<TaskModel> result = maps.map((e) => TaskModel.formJson(e)).toList();
    result.sort((a, b) => a.status!.compareTo(b.status!));
    return result;
  }

  Future<bool> deleteAllTasks() async {
    final db = await database;
    final result =
        await db.delete(TABLE_TASK);
    return result >= 0;
  }

  Future<bool> updateTask(TaskModel task) async {
    final db = await database;
    final result = await db.update(TABLE_TASK, task.toMap(),
        where: "id = ?", whereArgs: [task.id]);
    return result >= 0;
  }
}
