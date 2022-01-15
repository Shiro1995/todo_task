import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_task/models/task_model.dart';

const String DB_NAME = "task_database.db";
const String TABLE_TASK = "task";

class DatabaseProvider {

  Future<Database> _initDatabase() async {
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

  //delete the database
  Future deleteDB() async {
    return deleteDatabase(join(await getDatabasesPath(), DB_NAME));
  }

  Future<int> addTask(TaskModel task) async {
    final db = await _initDatabase();
    return db.insert(TABLE_TASK, task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<bool> checkExist(TaskModel task) async {
    final db = await _initDatabase();
    List<Map<String, dynamic>> maps =
        await db.query(TABLE_TASK, where: "id = ?", whereArgs: [task.id]);
    return maps.isNotEmpty;
  }

  Future<List<TaskModel>> getAllTasks() async {
    print('get all hello');
    final db = await _initDatabase();
    List<Map<String, dynamic>> maps = await db.query(TABLE_TASK);
    return maps.map((e) => TaskModel.formJson(e)).toList();
  }

  Future<bool> deleteAllTasks(TaskModel task) async {
    final db = await _initDatabase();
    final result =
        await db.delete(TABLE_TASK, where: "id = ?", whereArgs: [task.id]);
    return result >= 0;
  }

  Future<bool> updateTask(TaskModel task) async {
    final db = await _initDatabase();
    final result = await db.update(TABLE_TASK, task.toMap(),
        where: "id = ?", whereArgs: [task.id]);
    return result >= 0;
  }
}
