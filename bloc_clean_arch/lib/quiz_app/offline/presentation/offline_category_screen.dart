
import 'package:bloc_clean_arch/quiz_app/offline/data/local/quiz_repo_implementation.dart';
import 'package:bloc_clean_arch/quiz_app/offline/domain/quiz_repo.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'quiz_bloc/quiz_bloc.dart';
import 'ui_components/quiz_screen_view.dart';


class OfflineCategoryScreen extends StatefulWidget {
  const OfflineCategoryScreen({super.key});

  @override
  State<OfflineCategoryScreen> createState() => _OfflineCategoryScreenState();
}

class _OfflineCategoryScreenState extends State<OfflineCategoryScreen> {
  final QuizRepo quizRepo = QuizRepoImplementation();

  @override
  Widget build(BuildContext context) {
    return ConstrainedScaffold(
      appBar: AppBar(title: const Text(
          'Offline Category',
          style: TextStyle(fontWeight: FontWeight.bold)
      )),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) =>
                                          QuizBloc(quizRepo: quizRepo),
                                      child: const MyQuizScreen(
                                        questionCategory: 'physics',
                                        fromWeb: false,


                                      ),
                                    )));
                        // context.read<QuizBloc>().add(
                        //     const LoadQuestion(questionCategory: 'physics'));
                        // context.read<QuizBloc>().add(const NavigationEvent(
                        //     screenRoute: 'quiz_screen',
                        //     questionCategory: 'physics'));
                      },
                      id: 'Physics'),
                  MyButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) =>
                                        QuizBloc(quizRepo: quizRepo),
                                    child: const MyQuizScreen(
                                      questionCategory: 'chemistry',
                                      fromWeb: false,
                                    ),
                                  )));
                    },
                    id: 'Chemistry',
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
