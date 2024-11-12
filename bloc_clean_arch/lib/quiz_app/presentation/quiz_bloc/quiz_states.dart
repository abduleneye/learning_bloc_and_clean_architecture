import 'package:bloc_clean_arch/quiz_app/domain/quiz_model.dart';

class QuizStates {
  final int currentQ;
  final List<QuizModel> questions;
  final String? currentScreen;
  final String isOptionA;
  final String isOptionB;
  final String isOptionC;
  final String isOptionD;
  final String? correctAnswer;
  final bool correctAnswerVisibility;

  // final bool isOptionContainerEnabled;
  // final isPreviousButtonEnabled;
  // final isNextButtonEnabled;

  const QuizStates({
    required this.currentQ,
    required this.questions,
    required this.isOptionA,
    required this.isOptionB,
    required this.isOptionC,
    required this.isOptionD,
    required this.currentScreen,
    required this.correctAnswerVisibility,
    required this.correctAnswer,
    // required this.isOptionContainerEnabled,
    // required this.isNextButtonEnabled,
    // required this.isPreviousButtonEnabled
  });
}

class QuizLoading extends QuizStates {
  QuizLoading()
      : super(
            currentQ: 0,
            questions: [],
            isOptionA: '',
            isOptionB: '',
            isOptionC: '',
            isOptionD: '',
            currentScreen: '',
            correctAnswer: '',
            correctAnswerVisibility: false);
}

class QuizLoaded extends QuizStates {
  QuizLoaded()
      : super(
            currentQ: 0,
            questions: [],
            isOptionA: '',
            isOptionB: '',
            isOptionC: '',
            isOptionD: '',
            currentScreen: '',
            correctAnswer: '',
            correctAnswerVisibility: false);
}

class QuizError extends QuizStates {
  QuizError()
      : super(
            currentQ: 0,
            questions: [],
            isOptionA: '',
            isOptionB: '',
            isOptionC: '',
            isOptionD: '',
            currentScreen: '',
            correctAnswer: '',
            correctAnswerVisibility: false);
}

class QuizEnded extends QuizStates {
  QuizEnded()
      : super(
            currentQ: 0,
            questions: [],
            isOptionA: '',
            isOptionB: '',
            isOptionC: '',
            isOptionD: '',
            currentScreen: '',
            correctAnswer: '',
            correctAnswerVisibility: false);
}
