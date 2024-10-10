import 'package:bloc_clean_arch/quiz_app/question_holder_class_similar_to_my_kotlin_quiz_app.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_bloc/quiz_states.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizBloc extends Bloc<QuizEvents, QuizStates> {
  QuizBloc() : super(const QuizStates(currentQ: 0, q: [])) {
    final List<QuizModel> physicsQuestions =
        Question().GetQuestions(subjChoosen: 'chemistry');
    emit(QuizStates(currentQ: state.currentQ, q: physicsQuestions));

    on<LoadQuestion>((event, emit) {
      final List<QuizModel> physicsQuestions =
          Question().GetQuestions(subjChoosen: event.questionCategogry);
      emit(QuizStates(currentQ: state.currentQ, q: physicsQuestions));
      //print(chemistryQuestions);
    });

    on<NextQuestion>((event, emit) {
      if (state.currentQ < state.q.length - 1) {
        emit(QuizStates(currentQ: state.currentQ + 1, q: state.q));
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
      if (state.currentQ < state.q.length && state.currentQ != 0) {
        emit(QuizStates(currentQ: state.currentQ - 1, q: state.q));
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

    on<AnswerCheck>((event, emit) {
      if (event.selectedAnswer ==
          state.q[state.currentQ].correctAns['correctAns']) {
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
