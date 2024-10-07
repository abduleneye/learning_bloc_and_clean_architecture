import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calculator_cubit_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcBlocCubitProvider extends StatelessWidget {
  const CalcBlocCubitProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorCubitBloc(0),
      child: const MySimpleCalcView(),
    );
  }
}
