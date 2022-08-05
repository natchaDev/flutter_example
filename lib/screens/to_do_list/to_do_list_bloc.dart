
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/screens/to_do_list/to_do_list_event.dart';
import 'package:flutter_quiz_app/screens/to_do_list/to_do_list_state.dart';
import '../../data/repository/repository.dart';


class ToDoListBloc extends Bloc<ToDoListEvent, ToDoListState> {
  ToDoListBloc({required this.repository}) : super(ToDoListLoading()) {
    on<ToDoListStarted>(_onStarted);
    on<ToDoListItemAdded>(_onItemAdded);
    on<ToDoListPrioritySelected>(_onPrioritySelected);
    on<ToDoListItemChecked>(_onItemChecked);
    on<ToDoListItemRemoved>(_onItemRemoved);
  }

  final Repository repository;

  Future<void> _onStarted(ToDoListStarted event, Emitter<ToDoListState> emit) async {
    emit(ToDoListLoading());
    try {
      final priorityList = await repository.loadPriority();
      emit(PriorityLoaded(priorityList: priorityList));
      final toDoList = await repository.loadToDoList();
      emit(ToDoListLoaded(toDoList: toDoList));
    } catch (_) {
      emit(ToDoListError());
    }
  }

  Future<void> _onItemAdded(
      ToDoListItemAdded event,
      Emitter<ToDoListState> emit,
      ) async {
    final state = this.state;
    if (event.item.title.isEmpty) {
      return;
    }
    emit(ToDoListLoading());
    try {
      repository.addItem(event.item);
      await Future.delayed(Duration(milliseconds: 500));
      final toDoList = await repository.loadToDoList();
      emit(ToDoListLoaded(toDoList: toDoList));
    } catch (_) {
      emit(ToDoListError());
    }
  }

  Future<void> _onPrioritySelected(
      ToDoListPrioritySelected event,
      Emitter<ToDoListState> emit,
      ) async {
    emit(ToDoListLoading());
    try {
      repository.selectPriority(event.item);
      final priorityList = await repository.loadPriority();
      emit(PriorityLoaded(priorityList: priorityList));
    } catch (_) {
      emit(ToDoListError());
    }
  }

  Future<void> _onItemChecked(
      ToDoListItemChecked event,
      Emitter<ToDoListState> emit,
      ) async {
    final state = this.state;
    emit(ToDoListLoading());
    if (state is ToDoListLoaded) {
      try {
        repository.checked(event.item);
        await Future.delayed(Duration(milliseconds: 500));
        emit(ToDoListLoaded(toDoList:state.toDoList));
      } catch (_) {
        emit(ToDoListError());
      }
    }
  }

  Future<void> _onItemRemoved(
      ToDoListItemRemoved event,
      Emitter<ToDoListState> emit,
      ) async {
    final state = this.state;
    emit(ToDoListLoading());
    if (state is ToDoListLoaded) {
      try {
        repository.removeItem(event.item);
        await Future.delayed(Duration(milliseconds: 500));
        emit(ToDoListLoaded(toDoList:state.toDoList));
      } catch (_) {
        emit(ToDoListError());
      }
    }
  }

}