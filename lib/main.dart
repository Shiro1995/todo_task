import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/task_bloc_bloc.dart';
import 'package:todo_task/locator.dart';
import 'package:todo_task/ui/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (BuildContext context) => TaskBloc())],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: HomePage(),
      ),
    );
  }
}
