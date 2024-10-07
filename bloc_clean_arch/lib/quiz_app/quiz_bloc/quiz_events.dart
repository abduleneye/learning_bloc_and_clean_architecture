class QuizEvents {
  const QuizEvents();
}

class NextQuestion extends QuizEvents {
  final int currentQI;
  NextQuestion(this.currentQI);
}

class PreviousQuestion extends QuizEvents {
  final int currentQI;
  PreviousQuestion(this.currentQI);
}
