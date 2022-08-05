import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Priority extends Equatable {
  Priority({
    required this.index,
    required this.title,
    this.checked = false,
  });

  final int index;
  final String title;
  bool checked;


  @override
  List<Object> get props => [index, title, checked];

  @override
  String toString() {
    return 'ToDo{index: $index, title: $title, checked: $checked}';
  }

}
