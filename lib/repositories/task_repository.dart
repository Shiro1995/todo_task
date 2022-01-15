import 'package:todo_task/locator.dart';
import 'package:todo_task/models/task_model.dart';
import 'package:todo_task/network/database.dart';

class TaskRepository {
  final DatabaseProvider _databaseProvider = locator<DatabaseProvider>();

  Future<List<TaskModel>> getAllTasks() => _databaseProvider.getAllTasks();

  Future<int> addTask(TaskModel task) => _databaseProvider.addTask(task);
}
