import 'package:bloc_clean_arch/quiz_app/domain/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/quiz_app/domain/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/quiz_app/domain/quiz_bloc/quiz_states.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/ui_components/quiz_screen_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // context
    //     .read<QuizBloc>()
    //     .add(const LoadQuestion(questionCategogry: 'chemistry'));
    return BlocBuilder<QuizBloc, QuizStates>(
      builder: (context, state) {
        if (state.questions.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return WillPopScope(
            child: Scaffold(
                appBar: AppBar(
                  title: const Text('QUIZ SCREEN'),
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QuizCard(
                            containerColorState: '',
                            containerHeight: 100,
                            containerWidth: 350,
                            containerInnerPadding: 25,
                            questionOrOption:
                                state.questions[state.currentQ].question),
                        const SizedBox(
                          height: 10,
                        ),
                        QuizCard(
                            containerColorState: state.isOptionA,
                            onTap: () {
                              context.read<QuizBloc>().add(AnswerCheck(
                                  selectedAnswer: state
                                      .questions[state.currentQ].optionA['a']));
                            },
                            questionOrOption:
                                state.questions[state.currentQ].optionA['a']!,
                            containerHeight: 50,
                            containerWidth: 250,
                            containerInnerPadding: 10),
                        const SizedBox(
                          height: 10,
                        ),
                        QuizCard(
                          containerColorState: state.isOptionB,
                          onTap: () {
                            context.read<QuizBloc>().add(AnswerCheck(
                                selectedAnswer: state
                                    .questions[state.currentQ].optionB['b']));
                          },
                          questionOrOption:
                              state.questions[state.currentQ].optionB['b']!,
                          containerHeight: 50,
                          containerWidth: 250,
                          containerInnerPadding: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        QuizCard(
                          containerColorState: state.isOptionC,
                          onTap: () {
                            context.read<QuizBloc>().add(AnswerCheck(
                                selectedAnswer: state
                                    .questions[state.currentQ].optionC['c']));
                          },
                          questionOrOption:
                              state.questions[state.currentQ].optionC['c']!,
                          containerHeight: 50,
                          containerWidth: 250,
                          containerInnerPadding: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        QuizCard(
                          containerColorState: state.isOptionD,
                          onTap: () {
                            context.read<QuizBloc>().add(AnswerCheck(
                                selectedAnswer: state
                                    .questions[state.currentQ].optionD['d']));
                          },
                          questionOrOption:
                              state.questions[state.currentQ].optionD['d']!,
                          containerHeight: 50,
                          containerWidth: 250,
                          containerInnerPadding: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                // prev();
                                context
                                    .read<QuizBloc>()
                                    .add(PreviousQuestion());
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
                        ),
                        Visibility(
                          visible: state.correctAnswerVisibility,
                          child: Text(
                            'The correct answer is: ${state.correctAnswer.toString()}',
                            style: const TextStyle(color: Colors.green),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            onWillPop: () async {
              context.read<QuizBloc>().add(const NavigationEvent(
                  screenRoute: 'offline_mode_screen', questionCategory: null));
              return false;
            },
          );
        }
      },
    );
  }
}
