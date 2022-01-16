import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/task_bloc_bloc.dart';
import 'package:todo_task/ui/widgets/error_popup.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({Key? key}) : super(key: key);

  @override
  _ListTasksState createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(GetAllTask());
  }

  @override
  void dispose() {
    super.dispose();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
      if (state.statusLoading == LoadingStatus.initial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.statusLoading == LoadingStatus.loaded) {
        return ListView.builder(
            itemCount: state.listTasks!.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                key: Key(state.listTasks![index].id.toString()),
                title: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    '${state.listTasks![index].title}',
                    style: TextStyle(
                        decoration: state.listTasks![index].status == 1
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ),
                onChanged: (bool? value) {
                  setState(() {
                    var newTask = state.listTasks![index];
                    newTask.status = value == true ? 1 : 0;
                    context.read<TaskBloc>().add(UpdateTask(newTask));
                  });
                },
                value: state.listTasks![index].status == 1,
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('${state.listTasks?[index].description}'),
                ),
              );
            });
      } else {
        return PopupError(message: state.errorMessage ?? 'Somethings wrong!');
      }
    });
  }
}
