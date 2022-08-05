import 'package:equatable/equatable.dart';

import '../../models/priority.dart';
import '../../models/to_do.dart';

abstract class ToDoListState extends Equatable {
  const ToDoListState();
}

class ToDoListLoading extends ToDoListState {
  @override
  List<Object> get props => [];
}

class ToDoListLoaded extends ToDoListState {
  const ToDoListLoaded({this.toDoList, this.priorityList});

  final List<Priority>? priorityList;
  final List<ToDo>? toDoList;

  @override
  List<Object?> get props => [toDoList];
}

class PriorityLoaded extends ToDoListState {
  const PriorityLoaded({this.priorityList});

  final List<Priority>? priorityList;

  @override
  List<Object?> get props => [priorityList];
}

class ToDoListError extends ToDoListState {
  @override
  List<Object> get props => [];
}
