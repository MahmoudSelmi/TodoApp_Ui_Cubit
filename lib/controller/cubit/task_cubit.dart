import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Models/taskmodel.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void addTask(Taskmodel model) {
    emit(updatetaskstate([...state.taskslist, model]));
  }

  void removetask(String id) {
    final newlist = state.taskslist
        .where((element) => element.id != id)
        .toList();

    emit(updatetaskstate(newlist));
  }

  void toggleTask(String id) {
    final List<Taskmodel> newList = state.taskslist.map<Taskmodel>((task) {
      return task.id == id
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();

    emit(updatetaskstate(newList));
  }
}
