import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_states.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/ui_components/quiz_screen_card.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyQuizScreen extends StatefulWidget {
  final String questionCategory;
  const MyQuizScreen({super.key, required this.questionCategory});

  @override
  State<MyQuizScreen> createState() => _MyQuizScreenState();
}

class _MyQuizScreenState extends State<MyQuizScreen> {
  //List<QuizModel> questions =
  int currentQuestion = 0;
  List<String> shuffler({required List<String>  options }){
    List<String> shuffledOptions = options;
    shuffledOptions.shuffle();
    print(shuffledOptions);
    return shuffledOptions;
  }
  @override
  void initState() {
    super.initState();
    context
        .read<QuizBloc>()
        .add(LoadQuestion(questionCategory: widget.questionCategory));
  }
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
    return BlocBuilder<QuizBloc, QuizStates>(
      builder: (context, state) {
        if(state is QuizLoaded){
          if (state.questions.isEmpty) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return ConstrainedScaffold(
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
                            containerWidth:
                            MediaQuery.of(context).size.width / 1.18,
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
                                  selectedAnswer: state.questions[state.currentQ].allOptions[0]));
                            },
                            questionOrOption: '(a) ${state.questions[state.currentQ].allOptions[0]}',
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
                                selectedAnswer: state.questions[state.currentQ].allOptions[1]));
                          },
                          questionOrOption: '(b) ${state.questions[state.currentQ].allOptions[1]}',
                          containerHeight: 50,
                          containerWidth: 250,
                          containerInnerPadding: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        QuizCard(
                          containerColorState: state.isOptionC,
                          onTap: () {
                            context.read<QuizBloc>().add(AnswerCheck(
                                selectedAnswer: state.questions[state.currentQ].allOptions[2]));
                          },
                          questionOrOption: '(c) ${state.questions[state.currentQ].allOptions[2]}',
                          containerHeight: 50,
                          containerWidth: 250,
                          containerInnerPadding: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        QuizCard(
                          containerColorState: state.isOptionD,
                          onTap: () {
                            context.read<QuizBloc>().add(AnswerCheck(
                                selectedAnswer: state.questions[state.currentQ].allOptions[3]));
                          },
                          questionOrOption: '(d) ${state.questions[state.currentQ].allOptions[3]}',
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
                ));
          }

        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator())

        );

      },
    );
  }
}
