import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorCubitBloc extends Cubit<int> {
  final int result;
  CalculatorCubitBloc(this.result) : super(0);
  //CalculatorCubitBloc(super.initialState);

  void perCalc(String num1, String num2, String op) {
    int result = 0;
    if (op == '+') {
      result = int.parse(num1) + int.parse(num2);
      emit(result);
    } else if (op == '-') {
      result = int.parse(num1) - int.parse(num2);
      emit(result);
    } else if (op == '*') {
      result = int.parse(num1) * int.parse(num2);
      emit(result);
    } else if (op == '/') {
      result = int.parse(num1).toInt() ~/ int.parse(num2).toInt();
      emit(result);
    }
  }
}
