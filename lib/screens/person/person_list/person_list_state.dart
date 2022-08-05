import 'package:equatable/equatable.dart';

import '../../../models/person_entity.dart';


abstract class PersonListState extends Equatable {
  const PersonListState();
}

class PersonListLoading extends PersonListState {
  @override
  List<Object> get props => [];
}

class PersonListLoaded extends PersonListState {
  const PersonListLoaded({this.personList});

  final List<Person>? personList;

  @override
  List<Object?> get props => [personList];
}


class PersonListError extends PersonListState {
  @override
  List<Object> get props => [];
}
