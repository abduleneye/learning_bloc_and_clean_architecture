import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_textfield.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calculator_cubit_bloc.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySimpleCalcView extends StatefulWidget {
  const MySimpleCalcView({super.key});

  @override
  State<MySimpleCalcView> createState() => _MySimpleCalcViewState();
}

class _MySimpleCalcViewState extends State<MySimpleCalcView> {
  late final TextEditingController _num1;
  late final TextEditingController _num2;

  int _res = 0;

  void perCalc(String num1, String num2, String op) {
    setState(() {
      if (op == '+') {
        _res = int.parse(num1) + int.parse(num2);
      } else if (op == '-') {
        _res = int.parse(num1) - int.parse(num2);
      } else if (op == '*') {
        _res = int.parse(num1) * int.parse(num2);
      } else if (op == '/') {
        _res = int.parse(num1).toInt() ~/ int.parse(num2).toInt();
      }
    });
  }

  @override
  void initState() {
    _num1 = TextEditingController();
    _num2 = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorCubitBloc(0),
      child: ConstrainedScaffold(
          appBar: AppBar(
            title: const Text('Simple Calc'),
          ),
          body: BlocBuilder<CalculatorCubitBloc, int>(
            builder: (context, resState) {
              return Column(
                children: [
                  MyTextfield(
                      controller: _num1,
                      hintText: 'Enter a number',
                      obscureText: false),
                  const SizedBox(
                    height: 50,
                  ),
                  MyTextfield(
                    controller: _num2,
                    hintText: 'Enter a number:',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            id: '+',
                            onTap: () {
                              //perCalc(_num1.text, _num2.text, '+');
                              context
                                  .read<CalculatorCubitBloc>()
                                  .perCalc(_num1.text, _num2.text, '+');
                            },
                          ),
                          MyButton(
                            id: '-',
                            onTap: () {
                              //perCalc(_num1.text, _num2.text, '+');
                              context
                                  .read<CalculatorCubitBloc>()
                                  .perCalc(_num1.text, _num2.text, '-');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            id: '/',
                            onTap: () {
                              //perCalc(_num1.text, _num2.text, '+');
                              context
                                  .read<CalculatorCubitBloc>()
                                  .perCalc(_num1.text, _num2.text, '/');
                            },
                          ),
                          MyButton(
                            id: '*',
                            onTap: () {
                              //perCalc(_num1.text, _num2.text, '+');
                              context
                                  .read<CalculatorCubitBloc>()
                                  .perCalc(_num1.text, _num2.text, '*');
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(resState.toString())
                ],
              );
            },
          )),
    );
  }
}
