import 'package:equatable/equatable.dart';
import 'package:flutter_quiz_app/models/priority.dart';

import '../../models/to_do.dart';

abstract class ToDoListEvent extends Equatable {
  const ToDoListEvent();
}

class ToDoListStarted extends ToDoListEvent {
  @override
  List<Object> get props => [];
}


class ToDoListItemAdded extends ToDoListEvent {
  const ToDoListItemAdded(this.item);

  final ToDo item;

  @override
  List<Object> get props => [item];
}

class ToDoListPrioritySelected extends ToDoListEvent {
  const ToDoListPrioritySelected(this.item);

  final Priority? item;

  @override
  List<Object?> get props => [item];
}


class ToDoListItemChecked extends ToDoListEvent {
  const ToDoListItemChecked(this.item);

  final ToDo item;

  @override
  List<Object> get props => [item];
}

class ToDoListItemRemoved extends ToDoListEvent {
  const ToDoListItemRemoved(this.item);

  final ToDo item;

  @override
  List<Object> get props => [item];
}