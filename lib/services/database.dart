import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_task/models/task_model.dart';

const String dbName = "task_database.db";
const String tableTask = "task";

class DatabaseProvider {
  Database? _database;

  Future<Database> get database async {
    return await openDatabase(
      join(await getDatabasesPath(), dbName),
      version: 1,
      onCreate: (db, version) {
        return db.execute("""CREATE TABLE $tableTask (
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
    return deleteDatabase(join(await getDatabasesPath(), dbName));
  }

  Future<bool> addTask(TaskModel task) async {
    final db = await database;
    final result = await db.insert(tableTask, task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return result >= 0;
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableTask);
    if (maps.isEmpty) return [];
    List<TaskModel> result = maps.map((e) => TaskModel.formJson(e)).toList();
    result.sort((a, b) => a.status!.compareTo(b.status!));
    return result;
  }

  Future<bool> deleteAllTasks() async {
    final db = await database;
    final result =
        await db.delete(tableTask);
    return result >= 0;
  }

  Future<bool> updateTask(TaskModel task) async {
    final db = await database;
    final result = await db.update(tableTask, task.toMap(),
        where: "id = ?", whereArgs: [task.id]);
    return result >= 0;
  }
}
