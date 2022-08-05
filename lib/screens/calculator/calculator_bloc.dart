import 'package:flutter_bloc/flutter_bloc.dart';

enum Operation { plus, minus, multiple, divide }

class CalculatorEvent {
  final Operation operation;
  final String number1;
  final String number2;

  CalculatorEvent(this.operation, this.number1, this.number2);
}

class CalculatorBloc extends Bloc<CalculatorEvent, int> {
  CalculatorBloc() : super(0) {
    on<CalculatorEvent>((event, emit) {
      if (event.number1 == null || event.number2 == null) return emit(0);
      var num1 = int.parse(event.number1);
      var num2 = int.parse(event.number2);

      switch (event.operation) {
        case Operation.plus:
          return emit(num1 + num2);
          break;
        case Operation.minus:
          return emit(num1 - num2);
          break;
        case Operation.multiple:
          return emit(num1 * num2);
          break;
        case Operation.divide:
          return emit(num1 ~/ num2);
          break;
        default:
          return emit(0);
      }
    });
  }
}
