class QuizEvents {
  const QuizEvents();
}

class NextQuestion extends QuizEvents {
  NextQuestion();
}

class PreviousQuestion extends QuizEvents {
  PreviousQuestion();
}

class LoadQuestion extends QuizEvents {
  final String questionCategory;
  const LoadQuestion({required this.questionCategory});
}

class AnswerCheck extends QuizEvents {
  final String? selectedAnswer;
  const AnswerCheck({required this.selectedAnswer});
}

// class NavigationEvent extends QuizEvents {
//   final String screenRoute;
//   final String? questionCategory;
//   const NavigationEvent(
//       {required this.screenRoute, required this.questionCategory});
// }
