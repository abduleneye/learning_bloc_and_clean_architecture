import 'package:bloc_clean_arch/quiz_app/offline/domain/quiz_model.dart';

abstract class QuizStates {}

class QuizLoading extends QuizStates {
  QuizLoading();
}

class QuizInitial extends QuizStates {}

class QuizLoaded extends QuizStates {
final int currentQ;
final List<QuizModel> questions;
final String isOptionA;
final String isOptionB;
final String isOptionC;
final String isOptionD;
final String? correctAnswer;
final bool correctAnswerVisibility;
// final bool isOptionContainerEnabled;
  // final isPreviousButtonEnabled;
  // final isNextButtonEnabled;
  QuizLoaded({
    required this.currentQ,
    required this.questions,
    required this.isOptionA,
    required this.isOptionB,
    required this.isOptionC,
    required this.isOptionD,
    required this.correctAnswerVisibility,
    required this.correctAnswer,
});

  QuizLoaded copyWith({
     int? currentQ,
     List<QuizModel>? questions,
     String? isOptionA,
     String? isOptionB,
     String? isOptionC,
     String? isOptionD,
     String? correctAnswer,
     bool? correctAnswerVisibility
}){
    return QuizLoaded(
        currentQ: currentQ ?? this.currentQ,
        questions: questions ?? this.questions,
        isOptionA: isOptionA ?? this.isOptionA,
        isOptionB: isOptionB ?? this.isOptionB,
        isOptionC: isOptionC ?? this.isOptionC,
        isOptionD: isOptionD ?? this.isOptionD,
        correctAnswerVisibility: correctAnswerVisibility ?? this.correctAnswerVisibility,
        correctAnswer: correctAnswer ?? this.correctAnswer);

}


}

class QuizError extends QuizStates {

}

class QuizEnded extends QuizStates {

}
