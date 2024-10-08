import 'package:bloc_clean_arch/quiz_app/question_holder_class_similar_to_my_kotlin_quiz_app.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_bloc/quiz_states.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizBloc extends Bloc<QuizEvents, QuizStates> {
  QuizBloc() : super(const QuizStates(currentQ: 0, q: [])) {
    final List<QuizModel> chemistryQuestions =
        Question().GetQuestions(subjChoosen: 'chemistry');
    final List<QuizModel> physicsQuestions =
        Question().GetQuestions(subjChoosen: 'physics');
    emit(QuizStates(currentQ: state.currentQ, q: chemistryQuestions));

    on<LoadQuestion>((event, emit) {
      emit(QuizStates(currentQ: state.currentQ, q: physicsQuestions));
      //print(chemistryQuestions);
    });

    on<NextQuestion>((event, emit) {
      if (state.currentQ < event.currentQI - 1) {
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
      if (state.currentQ < event.currentQI && state.currentQ != 0) {
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
  }
}
