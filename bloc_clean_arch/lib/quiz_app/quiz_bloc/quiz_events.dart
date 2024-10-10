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
  final String questionCategogry;
  const LoadQuestion({required this.questionCategogry});
}

class AnswerCheck extends QuizEvents {
  final String? selectedAnswer;
  const AnswerCheck({required this.selectedAnswer});
}
