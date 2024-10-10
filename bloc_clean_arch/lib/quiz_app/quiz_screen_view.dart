import 'package:bloc_clean_arch/quiz_app/question_holder_class_similar_to_my_kotlin_quiz_app.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_bloc/quiz_states.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyQuizScreen extends StatefulWidget {
  const MyQuizScreen({super.key});

  @override
  State<MyQuizScreen> createState() => _MyQuizScreenState();
}

class _MyQuizScreenState extends State<MyQuizScreen> {
  //List<QuizModel> questions =
  int currentQuestion = 0;
  // void next() {
  //   setState(() {
  //     print('curr: ${currentQuestion}');
  //     print('que size: ${questions.length}');

  //     if (currentQuestion < questions.length - 1) {
  //       currentQuestion++;
  //       print('curr: ${currentQuestion}');
  //       print('que size: ${questions.length}');
  //     }
  //   });
  // }

  // void prev() {
  //   setState(() {
  //     print('curr: ${currentQuestion}');
  //     print('que size: ${questions.length}');

  //     if (currentQuestion < questions.length && currentQuestion != 0) {
  //       currentQuestion--;
  //       print('curr: ${currentQuestion}');
  //       print('que size: ${questions.length}');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('QUIZ SCREEN'),
          ),
          body: BlocBuilder<QuizBloc, QuizStates>(
            // listener: (context, state) {},
            builder: (context, state) {
              // context
              //     .read<QuizBloc>()
              //     .add(const LoadQuestion(questionCategogry: 'physics'));
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.q[state.currentQ].question
                      //questions[state.currentQ].question
                      ),
                  TextButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(AnswerCheck(
                          selectedAnswer:
                              state.q[state.currentQ].optionA['a']));
                    },
                    child: Text(state.q[state.currentQ].optionA['a']!),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(AnswerCheck(
                          selectedAnswer:
                              state.q[state.currentQ].optionB['b']));
                    },
                    child: Text(state.q[state.currentQ].optionB['b']!),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(AnswerCheck(
                          selectedAnswer:
                              state.q[state.currentQ].optionC['c']));
                    },
                    child: Text(state.q[state.currentQ].optionC['c']!),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(AnswerCheck(
                          selectedAnswer:
                              state.q[state.currentQ].optionD['d']));
                    },
                    child: Text(state.q[state.currentQ].optionD['d']!),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // prev();
                          context.read<QuizBloc>().add(PreviousQuestion());
                        },
                        child: const Text('Prev'),
                      ),
                      TextButton(
                        onPressed: () {
                          // next();
                          context.read<QuizBloc>().add(NextQuestion());
                        },
                        child: const Text('Next'),
                      )
                    ],
                  )
                ],
              );
            },
          )),
    );
  }
}
