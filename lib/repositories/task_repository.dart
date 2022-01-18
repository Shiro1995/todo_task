import 'package:todo_task/models/task_model.dart';
import 'package:todo_task/services/database.dart';

class TaskRepository {
  final DatabaseProvider _databaseProvider = DatabaseProvider();

  Future<List<TaskModel>> getAllTasks() => _databaseProvider.getAllTasks();

  Future<bool> addTask(TaskModel task) => _databaseProvider.addTask(task);

  Future<bool> updateTask(TaskModel task) => _databaseProvider.updateTask(task);

  Future<bool> deleteAllTasks() => _databaseProvider.deleteAllTasks();
}
