import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/task_bloc_bloc.dart';
import 'package:todo_task/ui/pages/add_task_page.dart';
import 'package:todo_task/ui/widgets/list_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<int> listStatus = [2, 1, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Todo App',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              BlocProvider.of<TaskBloc>(context).add(DeleteAllTasks());
            },
            icon: const Icon(
              Icons.save_outlined,
            ),
            label: Text(
              'Clear Data',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListTasks(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddTaskPage();
          })),
        },
        label: Text(
          'Add Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_headline_outlined),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_done_outlined),
            label: 'Incomplete',
          ),
        ],
        onTap: (index) => {
          setState(() {
            _selectedIndex = index;
          }),
          BlocProvider.of<TaskBloc>(context)
              .add(ChangeStatus(listStatus[index])),
        },
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.teal[300],
      ),
    );
  }
}
