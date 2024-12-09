import 'package:bloc_clean_arch/quiz_app/offline/data/local/quiz_repo_implementation.dart';
import 'package:bloc_clean_arch/quiz_app/offline/domain/quiz_repo.dart';
import 'package:bloc_clean_arch/quiz_app/offline/presentation/offline_category_screen.dart';
import 'package:bloc_clean_arch/quiz_app/offline/presentation/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'online_category_screen.dart';


class QuizHomeScreen extends StatefulWidget {
  const QuizHomeScreen({super.key});

  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
  final QuizRepo quizRepo = QuizRepoImplementation();
  @override
  Widget build(BuildContext context) {
    return ConstrainedScaffold(
        appBar: AppBar(
          title: const Text(
            'Q U I Z  H O M E',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocProvider(
          create: (context) => QuizBloc(quizRepo: quizRepo),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OfflineCategoryScreen()));

                          // context.read<QuizBloc>().add(const NavigationEvent(
                          //     screenRoute: 'offline_mode_screen',
                          //     questionCategory: null));
                        },
                        id: 'Offline',
                      ),
                      MyButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const OnlineCategoryScreen()));

                        },
                        id: 'Online',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
