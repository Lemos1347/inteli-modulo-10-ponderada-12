import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskService taskService;

  TaskBloc({required this.taskService}) : super(TasksLoadInProgress()) {
    // Estado inicial vazio
    on<LoadTasks>((event, emit) async {
      try {
        final tasks = await taskService.fetchTasks();
        emit(TasksLoadSuccess(tasks));
      } catch (_) {
        emit(TaskOperationFailure());
      }
    });

    on<AddTask>((event, emit) async {
      try {
        await taskService.addTask(event.task);
        final tasks = await taskService.fetchTasks();
        emit(TasksLoadSuccess(tasks));
      } catch (_) {
        emit(TaskOperationFailure());
      }
    });

    on<UpdateTask>((event, emit) async {
      try {
        await taskService.updateTask(event.task);
        final tasks = await taskService.fetchTasks();
        emit(TasksLoadSuccess(tasks));
      } catch (_) {
        emit(TaskOperationFailure());
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        await taskService.deleteTask(event.taskId);
        final tasks = await taskService.fetchTasks();
        emit(TasksLoadSuccess(tasks));
      } catch (_) {
        emit(TaskOperationFailure());
      }
    });
  }
}
