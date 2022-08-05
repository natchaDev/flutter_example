import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_person_state.dart';
import 'package:flutter_quiz_app/models/person_entity.dart';

import '../../../data/repository/repository.dart';

class StepCubit extends Cubit<CreatePersonState> {
  StepCubit({required this.repository, required this.stepperLength}) : super(const CreatePersonState());
  final Repository repository;
  final int stepperLength;
  Person? person;

  Future<void> createPerson(
      Person person,
      ) async {
    bool createSuccess = await repository.createPerson(person);
    emit(CreatePersonState(createSuccess: createSuccess));
  }

  void stepTapped(int tappedIndex) =>
      emit(CreatePersonState(activeStepperIndex: tappedIndex));

  void stepContinued({Person? person}) {
    if (state.activeStepperIndex < stepperLength - 1) {
      emit(CreatePersonState(activeStepperIndex: state.activeStepperIndex + 1));
    } else {
      if (person != null) {
        _createPerson(person);
      }
      emit(CreatePersonState(activeStepperIndex: state.activeStepperIndex));
    }
  }

  void stepCancelled() {
    if (state.activeStepperIndex > 0) {
      emit(CreatePersonState(activeStepperIndex: state.activeStepperIndex - 1));
    } else {
      emit(CreatePersonState(activeStepperIndex: state.activeStepperIndex));
    }
  }

  Future<void> _createPerson(
    Person person,
  ) async {
    await repository.createPerson(person);
  }
}