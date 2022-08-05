import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quiz_app/models/priority.dart';

@immutable
class ToDo extends Equatable {
  ToDo({
    required this.index,
    required this.title,
    this.priority,
    this.checked = false,
  });

  final int index;
  final String title;
  final Priority? priority;
  bool checked;


  @override
  List<Object?> get props => [index, title, priority, checked];

  @override
  String toString() {
    return 'ToDo{index: $index, title: $title, priority: $priority, checked: $checked}';
  }


}
