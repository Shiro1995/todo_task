part of 'task_bloc_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class GetAllTask extends TaskEvent {
  const GetAllTask();

  @override
  List<TaskModel?> get props => [];
}

class ChangeStatus extends TaskEvent {
  const ChangeStatus(this.status);
  final int status;
  @override
  List<TaskModel?> get props => [];
}

class UpdateTask extends TaskEvent {
  final TaskModel task;
  const UpdateTask(this.task);

  @override
  List<TaskModel> get props => [task];
}

class IsLoading extends TaskEvent {
  const IsLoading();

  @override
  List<TaskModel> get props => [];
}


class AddTask extends TaskEvent {
  final TaskModel task;
  const AddTask(this.task);

  @override
  List<TaskModel> get props => [task];
}


class DeleteAllTasks extends TaskEvent {
  const DeleteAllTasks();

  @override
  List<Object> get props => [];
}
