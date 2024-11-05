import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfflineCategoryScreen extends StatefulWidget {
  const OfflineCategoryScreen({super.key});

  @override
  State<OfflineCategoryScreen> createState() => _OfflineCategoryScreenState();
}

class _OfflineCategoryScreenState extends State<OfflineCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Offline Category')),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      onTap: () {},
                      id: 'Maths',
                    ),
                    MyButton(
                      onTap: () {},
                      id: 'English',
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                        onTap: () {
                          context.read<QuizBloc>().add(const NavigationEvent(
                              screenRoute: 'quiz_screen',
                              questionCategory: 'physics'));
                        },
                        id: 'Physics'),
                    MyButton(
                      onTap: () {
                        context.read<QuizBloc>().add(const NavigationEvent(
                            screenRoute: 'quiz_screen',
                            questionCategory: 'chemistry'));
                      },
                      id: 'Chemistry',
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        context.read<QuizBloc>().add(const NavigationEvent(
            screenRoute: 'mode_screen', questionCategory: null));
        return false;
      },
    );
  }
}
