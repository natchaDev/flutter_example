import 'package:equatable/equatable.dart';

abstract class PersonListEvent extends Equatable {
  const PersonListEvent();
}

class PersonListStarted extends PersonListEvent {
  @override
  List<Object> get props => [];
}


