import 'package:bloc_clean_arch/quiz_app/question_holder_class_similar_to_my_kotlin_quiz_app.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_bloc/quiz_states.dart';
import 'package:bloc_clean_arch/quiz_app/quiz_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizBloc extends Bloc<QuizEvents, QuizStates> {
  QuizBloc() : super(const QuestionIndex(0)) {
    final List<QuizModel> questions =
        Question().GetQuestions(subjChoosen: 'chemistry');
    //emit();

    on<NextQuestion>((event, emit) {
      if (state.currentQ < event.currentQI - 1) {
        emit(QuestionIndex(state.currentQ + 1));
      }
    });

    on<PreviousQuestion>((event, emit) {
      if (state.currentQ < event.currentQI && state.currentQ != 0) {
        emit(QuestionIndex(state.currentQ - 1));
      }
    });
  }
}
