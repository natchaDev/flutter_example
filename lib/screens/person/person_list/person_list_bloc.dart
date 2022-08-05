
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/data/repository/repository.dart';
import 'package:flutter_quiz_app/screens/person/person_list/person_list_event.dart';
import 'package:flutter_quiz_app/screens/person/person_list/person_list_state.dart';

class PersonListBloc extends Bloc<PersonListEvent, PersonListState> {
  PersonListBloc({required this.repository}) : super(PersonListLoading()) {
    on<PersonListStarted>(_onStarted);
  }

  final Repository repository;

  Future<void> _onStarted(PersonListStarted event, Emitter<PersonListState> emit) async {
    emit(PersonListLoading());
    try {
      final personList = await repository.loadPersonList();
      emit(PersonListLoaded(personList: personList));
    } catch (_) {
      emit(PersonListError());
    }
  }
}