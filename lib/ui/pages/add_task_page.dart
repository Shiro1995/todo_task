import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/task_bloc_bloc.dart';
import 'package:todo_task/models/task_model.dart';

// ignore: must_be_immutable
class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controlerTitle = TextEditingController();
  final TextEditingController _controlerDescription = TextEditingController();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Task'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controlerTitle,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                validator: (value) {
                  if (value == '') {
                    return 'Title can not be empty';
                  }
                },
                onSaved: (value) {
                  if (value != null) {
                    title = value;
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _controlerDescription,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onSaved: (value) {
                  if (value != null) {
                    description = value;
                  }
                },
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('Create'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final task = TaskModel(
                              title: title,
                              description: description,
                              status: 0);
                          BlocProvider.of<TaskBloc>(context).add(AddTask(task));
                          Navigator.pop(context);
                        }
                      },
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      child: Text('Clear'),
                      onPressed: () {
                        _formKey.currentState!.reset();
                        _controlerTitle.text = '';
                        _controlerDescription.text = '';
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
