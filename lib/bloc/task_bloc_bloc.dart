import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_task/locator.dart';
import 'package:todo_task/models/task_model.dart';
import 'package:todo_task/repositories/task_repository.dart';

part 'task_bloc_event.dart';
part 'task_bloc_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final _repository = locator<TaskRepository>();

  TaskBloc() : super(TaskState(status: LoadingStatus.initial)) {
    on<GetAllTask>(_getAllTasks);
    on<AddTask>(_addTask);
  }

  Future<void> _getAllTasks(GetAllTask event, Emitter<TaskState> emit) async {
    List<TaskModel> _listTasks = await _repository.getAllTasks();
    return emit(
        state.copyWith(listTasks: _listTasks, status: LoadingStatus.loaded));
  }

  Future<void> _addTask(AddTask event, Emitter<TaskState> emit) async {
    await _repository.addTask(event.task);
     List<TaskModel> _listTasks = await _repository.getAllTasks();
     return emit(
        state.copyWith(listTasks: _listTasks, status: LoadingStatus.loaded));
  }
}
