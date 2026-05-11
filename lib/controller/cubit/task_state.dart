part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  final List<Taskmodel> taskslist;
  const TaskState(this.taskslist);
  @override
  List<Object> get props => [taskslist];
}

final class TaskInitial extends TaskState {
  TaskInitial() : super([]);
}

final class updatetaskstate extends TaskState {
  const updatetaskstate(super.taskslist);
}
