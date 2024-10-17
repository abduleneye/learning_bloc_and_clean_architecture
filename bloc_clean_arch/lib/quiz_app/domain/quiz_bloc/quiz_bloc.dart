import 'package:bloc_clean_arch/quiz_app/question_holder_class_similar_to_my_kotlin_quiz_app.dart';
import 'package:bloc_clean_arch/quiz_app/domain/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/quiz_app/domain/quiz_bloc/quiz_states.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizBloc extends Bloc<QuizEvents, QuizStates> {
  QuizBloc()
      : super(const QuizStates(
          currentQ: 0,
          questions: [],
          currentScreen: 'mode_screen',
          isOptionA: '',
          isOptionB: '',
          isOptionC: '',
          isOptionD: '',
          correctAnswer: '',
          correctAnswerVisibility: false,
        )) {
    List<QuizModel> questions =
        Question().GetQuestions(subjChoosen: 'chemistry');
    // emit(QuizStates(
    //     currentQ: state.currentQ,
    //     questions: questions,
    //     currentScreen: state.currentScreen));

    // on<LoadQuestion>((event, emit) {
    //   emit(QuizStates(
    //       currentQ: state.currentQ,
    //       questions: questions,
    //       currentScreen: state.currentScreen));
    // });

    on<NextQuestion>((event, emit) {
      if (state.currentQ < state.questions.length - 1) {
        emit(QuizStates(
          currentQ: state.currentQ + 1,
          questions: state.questions,
          currentScreen: state.currentScreen,
          isOptionA: '',
          isOptionB: '',
          isOptionC: '',
          isOptionD: '',
          correctAnswer: '',
          correctAnswerVisibility: false,
        ));
      } else {
        Fluttertoast.showToast(
            msg: 'end of questions',
            //  toastLength: Toast.LENGTH_LONG,
            // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });

    on<PreviousQuestion>((event, emit) {
      if (state.currentQ < state.questions.length && state.currentQ != 0) {
        emit(QuizStates(
            currentQ: state.currentQ - 1,
            questions: state.questions,
            currentScreen: state.currentScreen,
            isOptionA: '',
            isOptionB: '',
            isOptionC: '',
            isOptionD: '',
            correctAnswer: '',
            correctAnswerVisibility: false));
      } else {
        Fluttertoast.showToast(
            msg: 'end of questions',
            //  toastLength: Toast.LENGTH_LONG,
            // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });

    on<NavigationEvent>(
      (event, emit) {
        if (event.questionCategory == 'physics') {
          questions = Question().GetQuestions(subjChoosen: 'physics');
          emit(QuizStates(
              currentQ: 0,
              questions: questions,
              currentScreen: event.screenRoute,
              isOptionA: '',
              isOptionB: '',
              isOptionC: '',
              isOptionD: '',
              correctAnswer: '',
              correctAnswerVisibility: false));
        } else if (event.questionCategory == 'chemistry') {
          questions = Question().GetQuestions(subjChoosen: 'chemistry');
          emit(QuizStates(
              currentQ: 0,
              questions: questions,
              currentScreen: event.screenRoute,
              isOptionA: '',
              isOptionB: '',
              isOptionC: '',
              isOptionD: '',
              correctAnswer: '',
              correctAnswerVisibility: false));
        } else {
          emit(QuizStates(
              currentQ: 0,
              questions: [],
              currentScreen: event.screenRoute,
              isOptionA: '',
              isOptionB: '',
              isOptionC: '',
              isOptionD: '',
              correctAnswer: '',
              correctAnswerVisibility: false));
        }
      },
    );

    on<AnswerCheck>((event, emit) {
      if (event.selectedAnswer ==
          state.questions[state.currentQ].optionA['a']) {
        if (event.selectedAnswer ==
            state.questions[state.currentQ].correctAns['correctAns']) {
          emit(QuizStates(
              currentQ: state.currentQ,
              questions: state.questions,
              currentScreen: state.currentScreen,
              isOptionA: 'iscorrect',
              isOptionB: '',
              isOptionC: '',
              isOptionD: '',
              correctAnswer: '',
              correctAnswerVisibility: false));
        } else {
          emit(QuizStates(
              currentQ: state.currentQ,
              questions: state.questions,
              currentScreen: state.currentScreen,
              isOptionA: 'iswrong',
              isOptionB: '',
              isOptionC: '',
              isOptionD: '',
              correctAnswer:
                  state.questions[state.currentQ].correctAns['correctAns'],
              correctAnswerVisibility: true));
        }
      } else if (event.selectedAnswer ==
          state.questions[state.currentQ].optionB['b']) {
        if (event.selectedAnswer ==
            state.questions[state.currentQ].correctAns['correctAns']) {
          emit(QuizStates(
              currentQ: state.currentQ,
              questions: state.questions,
              currentScreen: state.currentScreen,
              isOptionA: '',
              isOptionB: 'iscorrect',
              isOptionC: '',
              isOptionD: '',
              correctAnswer: '',
              correctAnswerVisibility: false));
        } else {
          emit(QuizStates(
              currentQ: state.currentQ,
              questions: state.questions,
              currentScreen: state.currentScreen,
              isOptionA: '',
              isOptionB: 'iswrong',
              isOptionC: '',
              isOptionD: '',
              correctAnswer:
                  state.questions[state.currentQ].correctAns['correctAns'],
              correctAnswerVisibility: true));
        }
      } else if (event.selectedAnswer ==
          state.questions[state.currentQ].optionC['c']) {
        if (event.selectedAnswer ==
            state.questions[state.currentQ].correctAns['correctAns']) {
          emit(QuizStates(
              currentQ: state.currentQ,
              questions: state.questions,
              currentScreen: state.currentScreen,
              isOptionA: '',
              isOptionB: '',
              isOptionC: 'iscorrect',
              isOptionD: '',
              correctAnswer: '',
              correctAnswerVisibility: false));
        } else {
          emit(QuizStates(
              currentQ: state.currentQ,
              questions: state.questions,
              currentScreen: state.currentScreen,
              isOptionA: '',
              isOptionB: '',
              isOptionC: 'iswrong',
              isOptionD: '',
              correctAnswer:
                  state.questions[state.currentQ].correctAns['correctAns'],
              correctAnswerVisibility: true));
        }
      } else if (event.selectedAnswer ==
          state.questions[state.currentQ].optionD['d']) {
        if (event.selectedAnswer ==
            state.questions[state.currentQ].correctAns['correctAns']) {
          emit(QuizStates(
            currentQ: state.currentQ,
            questions: state.questions,
            currentScreen: state.currentScreen,
            isOptionA: '',
            isOptionB: '',
            isOptionC: '',
            isOptionD: 'iscorrect',
            correctAnswerVisibility: false,
            correctAnswer:
                state.questions[state.currentQ].correctAns['correctAns'],
          ));
        } else {
          emit(QuizStates(
              currentQ: state.currentQ,
              questions: state.questions,
              currentScreen: state.currentScreen,
              isOptionA: '',
              isOptionB: '',
              isOptionC: '',
              isOptionD: 'iswrong',
              correctAnswer:
                  state.questions[state.currentQ].correctAns['correctAns'],
              correctAnswerVisibility: true));
        }
      }

      // if (event.selectedAnswer ==
      //     state.questions[state.currentQ].correctAns['correctAns']) {
      //   emit(QuizStates(
      //     currentQ: state.currentQ,
      //     questions: state.questions,
      //     currentScreen: state.currentScreen,
      //     isOptionA: event.selectedAnswer ==
      //             state.questions[state.currentQ].optionA['a']
      //         ? 'iscorrect'
      //         : '',
      //     isOptionB: event.selectedAnswer ==
      //             state.questions[state.currentQ].optionB['b']
      //         ? 'iscorrect'
      //         : '',
      //     isOptionC: event.selectedAnswer ==
      //             state.questions[state.currentQ].optionC['c']
      //         ? 'iscorrect'
      //         : '',
      //     isOptionD: event.selectedAnswer ==
      //             state.questions[state.currentQ].optionD['d']
      //         ? 'iscorrect'
      //         : '',
      //   ));
      //   print('printing option a status: ${QuizStates(
      //     currentQ: state.currentQ,
      //     questions: state.questions,
      //     isOptionA: state.isOptionA,
      //     isOptionB: state.isOptionB,
      //     isOptionC: state.isOptionC,
      //     isOptionD: state.isOptionD,
      //     currentScreen: state.currentScreen,
      //   ).isOptionA}');
      //   print('printing option b status ${QuizStates(
      //     currentQ: state.currentQ,
      //     questions: state.questions,
      //     isOptionA: state.isOptionA,
      //     isOptionB: state.isOptionB,
      //     isOptionC: state.isOptionC,
      //     isOptionD: state.isOptionD,
      //     currentScreen: state.currentScreen,
      //   ).isOptionB}');
      //   print('printing option c status ${QuizStates(
      //     currentQ: state.currentQ,
      //     questions: state.questions,
      //     isOptionA: state.isOptionA,
      //     isOptionB: state.isOptionB,
      //     isOptionC: state.isOptionC,
      //     isOptionD: state.isOptionD,
      //     currentScreen: state.currentScreen,
      //   ).isOptionC}');
      //   print('printing option d status ${QuizStates(
      //     currentQ: state.currentQ,
      //     questions: state.questions,
      //     isOptionA: state.isOptionA,
      //     isOptionB: state.isOptionB,
      //     isOptionC: state.isOptionC,
      //     isOptionD: state.isOptionD,
      //     currentScreen: state.currentScreen,
      //   ).isOptionD}');
      //   Fluttertoast.showToast(
      //       msg: 'correct',
      //       //  toastLength: Toast.LENGTH_LONG,
      //       // gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.green,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      //   print('Correct');
      // } else {
      //   emit(QuizStates(
      //     currentQ: state.currentQ,
      //     questions: state.questions,
      //     currentScreen: state.currentScreen,
      //     isOptionA: event.selectedAnswer !=
      //             state.questions[state.currentQ].optionA['a']
      //         ? 'iswrong'
      //         : 'iswrong',
      //     isOptionB: event.selectedAnswer !=
      //             state.questions[state.currentQ].optionB['b']
      //         ? 'iswrong'
      //         : 'iswrong',
      //     isOptionC: event.selectedAnswer !=
      //             state.questions[state.currentQ].optionC['c']
      //         ? 'iswrong'
      //         : 'iswrong',
      //     isOptionD: event.selectedAnswer !=
      //             state.questions[state.currentQ].optionD['d']
      //         ? 'iswrong'
      //         : 'iswrong',
      //   ));
      //   print('printing option a status: ${QuizStates(
      //     currentQ: state.currentQ,
      //     questions: state.questions,
      //     isOptionA: state.isOptionA,
      //     isOptionB: state.isOptionB,
      //     isOptionC: state.isOptionC,
      //     isOptionD: state.isOptionD,
      //     currentScreen: state.currentScreen,
      //   ).isOptionA}');
      //   print('printing option b status: ${QuizStates(
      //     currentQ: state.currentQ,
      //     questions: state.questions,
      //     isOptionA: state.isOptionA,
      //     isOptionB: state.isOptionB,
      //     isOptionC: state.isOptionC,
      //     isOptionD: state.isOptionD,
      //     currentScreen: state.currentScreen,
      //   ).isOptionB}');
      //   print('printing option c status: ${QuizStates(
      //     currentQ: state.currentQ,
      //     questions: state.questions,
      //     isOptionA: state.isOptionA,
      //     isOptionB: state.isOptionB,
      //     isOptionC: state.isOptionC,
      //     isOptionD: state.isOptionD,
      //     currentScreen: state.currentScreen,
      //   ).isOptionC}');
      //   print('printing option d status: ${QuizStates(
      //     currentQ: state.currentQ,
      //     questions: state.questions,
      //     isOptionA: state.isOptionA,
      //     isOptionB: state.isOptionB,
      //     isOptionC: state.isOptionC,
      //     isOptionD: state.isOptionD,
      //     currentScreen: state.currentScreen,
      //   ).isOptionD}');
      //   Fluttertoast.showToast(
      //       msg: 'wrong',
      //       //  toastLength: Toast.LENGTH_LONG,
      //       // gravity: ToastGravity.CENTER,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      //   print('Wrong');
      // }
    });
  }
}
