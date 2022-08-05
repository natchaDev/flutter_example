
import 'package:equatable/equatable.dart';

class CreatePersonState extends Equatable {
  const CreatePersonState({
    this.activeStepperIndex = 0,
    this.createSuccess = false,
  });

  final int activeStepperIndex;
  final bool createSuccess;

  CreatePersonState copyWith({int? activeStepperIndex, bool? createSuccess}) {
    return CreatePersonState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
      createSuccess: createSuccess ?? this.createSuccess,
    );
  }

  @override
  List<Object> get props => [activeStepperIndex, createSuccess];
}