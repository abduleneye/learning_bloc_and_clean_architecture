import 'package:bloc_clean_arch/quiz_app/domain/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/quiz_app/domain/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizModeHomeScreen extends StatefulWidget {
  const QuizModeHomeScreen({super.key});

  @override
  State<QuizModeHomeScreen> createState() => _QuizModeHomeScreenState();
}

class _QuizModeHomeScreenState extends State<QuizModeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizHomeScreen'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    onTap: () {
                      context.read<QuizBloc>().add(const NavigationEvent(
                          screenRoute: 'offline_mode_screen',
                          questionCategory: null));
                    },
                    id: 'Offline',
                  ),
                  MyButton(
                    onTap: () {},
                    id: 'Online',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
