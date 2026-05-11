import 'package:equatable/equatable.dart';

class Taskmodel extends Equatable {
  final String title;
  final String id;
  final bool isCompleted;

  const Taskmodel({
    required this.title,
    required this.id,
    this.isCompleted = false,
  });
  copywith({String? title, String? id, bool? isCompleted}) {
    return Taskmodel(
      title: title ?? this.title,
      id: id ?? this.id,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [title, id, isCompleted];

  copyWith({required bool isCompleted}) {}
}
