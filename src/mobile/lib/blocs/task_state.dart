import '../models/task.dart';

abstract class TaskState {}

class TasksLoadInProgress extends TaskState {}

class TasksLoadSuccess extends TaskState {
  final List<Task> tasks;

  TasksLoadSuccess(this.tasks);
}

class TaskOperationFailure extends TaskState {}
