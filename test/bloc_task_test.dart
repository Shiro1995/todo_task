import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_task/bloc/task_bloc_bloc.dart';
import 'package:todo_task/models/task_model.dart';
import 'package:todo_task/repositories/task_repository.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

class MockTaskBloc extends MockBloc<TaskEvent, TaskState> implements TaskBloc {}

// ignore: must_be_immutable
class MockTask extends Mock implements TaskModel {}

void main() {
  final task =
      TaskModel(id: 1, title: 'title', description: 'description', status: 0);
  // final List<TaskModel> listTask = [
  //   TaskModel(id: 1, title: 'title', description: 'description', status: 0)
  // ];
  group('main BLoc', () {
    TaskBloc taskBloc;

    group('blocTask', () {
      taskBloc = MockTaskBloc();
      blocTest<TaskBloc, TaskState>(
        'emit data after get tasks from database',
        build: () => taskBloc,
        act: (bloc) => bloc.add(GetAllTask()),
        expect: () => <TaskState>[],
      );

      blocTest<TaskBloc, TaskState>(
        'emit data after add task from database',
        build: () => taskBloc,
        act: (bloc) => bloc.add(AddTask(task)),
        expect: () => <TaskState>[],
      );

      blocTest<TaskBloc, TaskState>(
        'emit update data after get tasks from database',
        build: () => taskBloc,
        act: (bloc) => bloc.add(UpdateTask(task)),
        expect: () => <TaskState>[],
      );

      blocTest<TaskBloc, TaskState>(
        'emit data after add task from database',
        build: () => taskBloc,
        act: (bloc) => bloc.add(DeleteAllTasks()),
        expect: () => <TaskState>[],
      );
    });
  });
}
