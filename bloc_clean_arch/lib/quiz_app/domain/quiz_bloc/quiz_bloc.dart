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
          ));
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
          ));
        } else {
          emit(QuizStates(
            currentQ: 0,
            questions: [],
            currentScreen: event.screenRoute,
            isOptionA: '',
            isOptionB: '',
            isOptionC: '',
            isOptionD: '',
          ));
        }
      },
    );

    on<AnswerCheck>((event, emit) {
      if (event.selectedAnswer ==
          state.questions[state.currentQ].correctAns['correctAns']) {
        emit(QuizStates(
          currentQ: state.currentQ,
          questions: state.questions,
          currentScreen: state.currentScreen,
          isOptionA: event.selectedAnswer ==
                  state.questions[state.currentQ].optionA['a']
              ? 'iscorrect'
              : 'iswrong',
          isOptionB: event.selectedAnswer ==
                  state.questions[state.currentQ].optionB['b']
              ? 'iscorrect'
              : 'iswrong',
          isOptionC: event.selectedAnswer ==
                  state.questions[state.currentQ].optionC['c']
              ? 'iscorrect'
              : 'iswrong',
          isOptionD: event.selectedAnswer ==
                  state.questions[state.currentQ].optionD['d']
              ? 'iscorrect'
              : 'iswrong',
        ));
        Fluttertoast.showToast(
            msg: 'correct',
            //  toastLength: Toast.LENGTH_LONG,
            // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        print('Correct');
      } else {
        Fluttertoast.showToast(
            msg: 'wrong',
            //  toastLength: Toast.LENGTH_LONG,
            // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print('Wrong');
      }
    });
  }
}
