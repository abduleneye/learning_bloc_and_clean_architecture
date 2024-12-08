import 'package:bloc_clean_arch/quiz_app/domain/quiz_repo.dart';
import 'package:bloc_clean_arch/quiz_app/question_holder_class_similar_to_my_kotlin_quiz_app.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_bloc/quiz_states.dart';
import 'package:bloc_clean_arch/quiz_app/domain/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class QuizBloc extends Bloc<QuizEvents, QuizStates> {
  final QuizRepo quizRepo;
  QuizBloc({required this.quizRepo})
      : super( QuizInitial()) {

    on<LoadQuestion>((event, emit) async {
      emit(QuizLoading());
      try{
        final loadedQuestions =
        await quizRepo.fetchQuizQuestions(category: event.questionCategory);


        emit(QuizLoaded(
            currentQ: 0,
            questions: loadedQuestions,
            // shuffledOptions: state.questions[state.currentQ].allOptions,
            isOptionA: "",
            isOptionB: "",
            isOptionC: "",
            isOptionD: "",
            correctAnswerVisibility: false,
            correctAnswer: ""));

      }catch(e){
        emit(QuizError());

      }
      });


    on<NextQuestion>((event, emit){
      final currentState = state;
      if(currentState is QuizLoaded){
        if (currentState.currentQ < currentState.questions.length - 1) {
          emit(currentState.copyWith(
            currentQ: currentState.currentQ + 1,
            questions: currentState.questions,
            correctAnswerVisibility: false,
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

      }

    });

    on<PreviousQuestion>((event, emit) {
      final currentState = state;
      if(currentState is QuizLoaded){
    if (currentState.currentQ < currentState.questions.length && currentState.currentQ != 0) {
    emit(currentState.copyWith(
        currentQ: currentState.currentQ - 1,
        isOptionA: '',
        isOptionB: '',
        isOptionC: '',
        isOptionD: '',
        correctAnswerVisibility: false));
    } else {
      //emit(QuizEnded());
      Fluttertoast.showToast(
          msg: 'end of questions',
          //  toastLength: Toast.LENGTH_LONG,
          // gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
      }

    });


    on<AnswerCheck>((event, emit) {
      final currentState = state;
      if(currentState is QuizLoaded){

        if (event.selectedAnswer == currentState.questions[currentState.currentQ].allOptions[0]) {
          if (event.selectedAnswer ==
              currentState.questions[currentState.currentQ].correctOption) {
            emit(currentState.copyWith(
                isOptionA: 'iscorrect',
                isOptionB: '',
                isOptionC: '',
                isOptionD: '',
                correctAnswerVisibility: false
            ));
          } else {
            emit(currentState.copyWith(
                isOptionA: 'iswrong',
                isOptionB: '',
                isOptionC: '',
                isOptionD: '',
                correctAnswer: currentState.questions[currentState.currentQ].correctOption,
                correctAnswerVisibility: true));
          }
        } else if (event.selectedAnswer == currentState.questions[currentState.currentQ].allOptions[1]) {
          if (event.selectedAnswer ==
              currentState.questions[currentState.currentQ].correctOption) {
            emit(currentState.copyWith(
                isOptionA: '',
                isOptionB: 'iscorrect',
                isOptionC: '',
                isOptionD: '',
                correctAnswerVisibility: false));
          } else {
            emit(currentState.copyWith(
                isOptionA: '',
                isOptionB: 'iswrong',
                isOptionC: '',
                isOptionD: '',
                correctAnswer: currentState.questions[currentState.currentQ].correctOption,
                correctAnswerVisibility: true));
          }
        } else if (event.selectedAnswer == currentState.questions[currentState.currentQ].allOptions[2]) {
          if (event.selectedAnswer ==
              currentState.questions[currentState.currentQ].correctOption) {
            emit(currentState.copyWith(
                isOptionA: '',
                isOptionB: '',
                isOptionC: 'iscorrect',
                isOptionD: '',
                correctAnswerVisibility: false));
          } else {
            emit(currentState.copyWith(
                isOptionA: '',
                isOptionB: '',
                isOptionC: 'iswrong',
                isOptionD: '',
                correctAnswer: currentState.questions[currentState.currentQ].correctOption,
                correctAnswerVisibility: true));
          }
        } else if (event.selectedAnswer ==
            currentState.questions[currentState.currentQ].allOptions[3]) {
          if (event.selectedAnswer ==
              currentState.questions[currentState.currentQ].correctOption) {
            emit(currentState.copyWith(
              isOptionA: '',
              isOptionB: '',
              isOptionC: '',
              isOptionD: 'iscorrect',
              correctAnswerVisibility: false,
              correctAnswer: currentState.questions[currentState.currentQ].correctOption,
            ));
          } else {
            emit(currentState.copyWith(
                isOptionA: '',
                isOptionB: '',
                isOptionC: '',
                isOptionD: 'iswrong',
                correctAnswer: currentState.questions[currentState.currentQ].correctOption,
                correctAnswerVisibility: true));
          }
        }

      }

    });
  }



}


