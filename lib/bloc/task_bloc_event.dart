part of 'task_bloc_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class GetAllTask extends TaskEvent {
  const GetAllTask();

  @override
  List<TaskModel?> get props => [];
}


class GetTaskByStatus extends TaskEvent {
  final int status;
  const GetTaskByStatus(this.status);

  @override
  List<Object> get props => [status];
}

class AddTask extends TaskEvent {
  final TaskModel task;
  const AddTask(this.task);

  @override
  List<TaskModel> get props => [task];
}

class UpdateTask extends TaskEvent {
  final TaskModel model;
  const UpdateTask(this.model);

  @override
  List<TaskModel> get props => [model];
}

class DeleteAllTasks extends TaskEvent {
  const DeleteAllTasks();

  @override
  List<Object> get props => [];
}
