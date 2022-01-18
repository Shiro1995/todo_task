import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_task/bloc/task_bloc_bloc.dart';
import 'package:todo_task/models/task_model.dart';
import 'package:todo_task/repositories/task_repository.dart';
import 'package:todo_task/services/database.dart';
import 'package:todo_task/ui/pages/home_page.dart';
import 'package:todo_task/ui/widgets/list_task.dart';

class MockTaskRepository extends Mock implements TaskRepository {
}

class MockTaskBloc extends MockBloc<TaskEvent, TaskState> implements TaskBloc {}

extension on WidgetTester {
  Future<void> pumpHomePage(MockTaskRepository repository) {
    return pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => TaskBloc(repository))
          ],
          child: HomePage(),
        ),
      ),
    );
  }

  Future<void> pumpListTask(MockTaskRepository repository) {
    return pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => TaskBloc(repository))
          ],
          child: ListTasks(),
        ),
      ),
    );
  }
}

@GenerateMocks([TaskRepository, DatabaseProvider])
void main() {
  final listTask = [
    TaskModel(id: 1, title: '1', description: 'des', status: 0),
    TaskModel(id: 1, title: '1', description: 'des', status: 0),
  ];
  final task =
      TaskModel(id: 1, title: 'title', description: 'description', status: 0);

  MockTaskRepository repository;
  late TaskBloc taskBloc;

  setUpAll(() {
    repository = MockTaskRepository();
    taskBloc = MockTaskBloc();
    final DatabaseProvider databaseProvider = DatabaseProvider();
    databaseProvider.addTask(task);
  });

  TestWidgetsFlutterBinding.ensureInitialized();

  group('Home Page Widget Tests', () {
    repository = MockTaskRepository();
    testWidgets('test Home Page', (tester) async {
      await tester.pumpHomePage(repository);
      expect(find.byType(ListTasks), findsOneWidget);
    });
  });
  group('ListTask Widget Test', () {
    testWidgets('test list task loaded', (tester) async {
      repository = MockTaskRepository();
      await tester.pumpListTask(repository);
      when(repository.getAllTasks()).thenAnswer((_) async => listTask);
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
