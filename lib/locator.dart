import 'package:get_it/get_it.dart';
import 'package:todo_task/network/database.dart';
import 'package:todo_task/repositories/task_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<TaskRepository>(() => TaskRepository());
  locator.registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());
}
