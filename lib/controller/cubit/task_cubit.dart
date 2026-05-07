import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Models/taskmodel.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  addTasl(Taskmodel model) {
    emit(updatetaskstate([...state.taskslist, model]));
  }

  removetask(int id) {}
  toggletask() {}
}
