part of 'task_bloc_bloc.dart';

enum LoadingStatus { initial, loaded, failure }

class TaskState extends Equatable {
  const TaskState({
    this.listTasks,
    this.statusLoading = LoadingStatus.initial,
    this.errorMessage,
    this.status,
  });

  final List<TaskModel>? listTasks;
  final LoadingStatus? statusLoading;
  final String? errorMessage;
  final int? status;

  TaskState copyWith(
          {LoadingStatus? statusLoading,
          List<TaskModel>? listTasks,
          String? errorMessage,
          int? status}) =>
      TaskState(
          statusLoading: statusLoading ?? this.statusLoading,
          listTasks: listTasks ?? this.listTasks,
          errorMessage: errorMessage ?? this.errorMessage,
          status: status ?? this.status
          );

  @override
  List<Object?> get props => [statusLoading, status, listTasks, statusLoading];
}
