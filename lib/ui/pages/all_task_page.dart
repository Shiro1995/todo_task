import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/task_bloc_bloc.dart';
import 'package:todo_task/models/task_model.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({Key? key}) : super(key: key);

  @override
  _AllTasksPageState createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetAllTask());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      if (state.status == LoadingStatus.initial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == LoadingStatus.loaded) {
        return ListView.builder(
            itemCount: state.listTasks!.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('${state.listTasks![index].title}'),
                ),
                onChanged: (bool? value) {},
                value: true,
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('hi'),
                ),
              );
            });
      }
      return Text(state.status.toString());
    });
  }
}
