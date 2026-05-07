import 'package:equatable/equatable.dart';

class Taskmodel extends Equatable {
  final String title;
  final String id;
  final bool isCompleted;

  Taskmodel({required this.title, required this.id, this.isCompleted = false});

  @override
  List<Object?> get props => [title, id, isCompleted];
}
