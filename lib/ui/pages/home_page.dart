import 'package:flutter/material.dart';
import 'package:todo_task/bloc/task_bloc_bloc.dart';
import 'package:todo_task/models/task_model.dart';
import 'package:todo_task/ui/pages/all_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _listTask = [AllTasksPage(), Text('2'), Text('3')];

  late int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Todo App',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: _listTask[_selectedIndex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          
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
          })
        },
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.teal[300],
      ),
    );
  }
}
