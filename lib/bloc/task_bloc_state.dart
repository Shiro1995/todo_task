part of 'task_bloc_bloc.dart';

enum LoadingStatus { initial, loaded, failure }

class TaskState extends Equatable {
  const TaskState({
    this.listTasks,
    this.status = LoadingStatus.initial,
  });

  final List<TaskModel>? listTasks;
  final LoadingStatus? status;

  TaskState copyWith({LoadingStatus? status, List<TaskModel>? listTasks}) =>
      TaskState(
          status: status ?? this.status,
          listTasks: listTasks ?? this.listTasks);

  @override
  List<Object?> get props => [listTasks, status];
}
