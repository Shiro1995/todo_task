import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/locator.dart';
import 'package:todo_task/models/task_model.dart';
import 'package:todo_task/repositories/task_repository.dart';

part 'task_bloc_event.dart';
part 'task_bloc_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final _repository = TaskRepository();

  TaskBloc(TaskRepository taskRepository)
      : super(TaskState(statusLoading: LoadingStatus.initial, status: 2)) {
    on<GetAllTask>(_getAllTasks);
    on<AddTask>(_addTask);
    on<ChangeStatus>(_changeStatus);
    on<UpdateTask>(_udpateTask);
    on<DeleteAllTasks>(_delteAllTasks);
  }

  _changeStatus(ChangeStatus event, Emitter<TaskState> emit) async {
    emit(state.copyWith(statusLoading: LoadingStatus.initial));
    List<TaskModel> _listTasks = await _repository.getAllTasks();
    if (event.status == 2) {
      emit(state.copyWith(
          listTasks: _listTasks,
          status: event.status,
          statusLoading: LoadingStatus.loaded));
    } else {
      List<TaskModel> newList =
          _listTasks.where((item) => item.status == event.status).toList();
      emit(state.copyWith(
          listTasks: newList,
          status: event.status,
          statusLoading: LoadingStatus.loaded));
    }
  }

  Future<void> _getAllTasks(GetAllTask event, Emitter<TaskState> emit) async {
    List<TaskModel> _listTasks = await _repository.getAllTasks();
    return emit(state.copyWith(
        listTasks: _listTasks, statusLoading: LoadingStatus.loaded));
  }

  Future<void> _addTask(AddTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(statusLoading: LoadingStatus.initial));
    final result = await _repository.addTask(event.task);
    if (result) {
      List<TaskModel> _listTasks = await _repository.getAllTasks();
      if (state.status == 2) {
        emit(state.copyWith(
            listTasks: _listTasks,
            status: state.status,
            statusLoading: LoadingStatus.loaded));
      } else {
        List<TaskModel> newList =
            _listTasks.where((item) => item.status == state.status).toList();
        emit(state.copyWith(
            listTasks: newList,
            status: state.status,
            statusLoading: LoadingStatus.loaded));
      }
    } else {
      emit(state.copyWith(
          errorMessage: 'Update failed', statusLoading: LoadingStatus.failure));
    }
  }

  void _udpateTask(UpdateTask event, Emitter<TaskState> emit) async {
    final result = await _repository.updateTask(event.task);
    if (result) {
      List<TaskModel> _listTasks = await _repository.getAllTasks();
      if (state.status == 2) {
        emit(state.copyWith(
            listTasks: _listTasks,
            status: state.status,
            statusLoading: LoadingStatus.loaded));
      } else {
        List<TaskModel> newList =
            _listTasks.where((item) => item.status == state.status).toList();
        emit(state.copyWith(
            listTasks: newList,
            status: state.status,
            statusLoading: LoadingStatus.loaded));
      }
    } else {
      emit(state.copyWith(
          errorMessage: 'Update failed', statusLoading: LoadingStatus.failure));
    }
  }

  Future<void> _delteAllTasks(
      DeleteAllTasks event, Emitter<TaskState> emit) async {
    final result = await _repository.deleteAllTasks();
    if (result) {
      return emit(
          state.copyWith(listTasks: [], statusLoading: LoadingStatus.loaded));
    }
    return emit(state.copyWith(
        errorMessage: 'Deleted failed', statusLoading: LoadingStatus.failure));
  }
}
