import 'package:bloc_clean_arch/quiz_app/offline/data/local/quiz_repo_implementation.dart';
import 'package:bloc_clean_arch/quiz_app/offline/domain/quiz_repo.dart';
import 'package:bloc_clean_arch/quiz_app/offline/presentation/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/quiz_app/offline/presentation/upload_question_entry_modifier.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadQuestionsPage extends StatefulWidget {
  const UploadQuestionsPage({super.key});

  @override
  State<UploadQuestionsPage> createState() => _UploadQuestionsPageState();
}

class _UploadQuestionsPageState extends State<UploadQuestionsPage> {
  final QuizRepo quizRepo = QuizRepoImplementation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Questions"),
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
                                  child: const UploadQuestionEntryModifierPage(questionCategory: "physics"),
                                )));

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
                                child: const UploadQuestionEntryModifierPage(questionCategory: "chemistry"),
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
