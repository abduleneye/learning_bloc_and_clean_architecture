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
  final bool isFromWeb;
  final String questionCategory;
  const LoadQuestion({
    required this.questionCategory,
    required this.isFromWeb
  });
}

class AnswerCheck extends QuizEvents {
  final String? selectedAnswer;
  const AnswerCheck({required this.selectedAnswer});
}

class UploadQuestionToFireStore extends QuizEvents {
  final String questions;
  final String questionCategory;

  const UploadQuestionToFireStore({
    required this.questions,
    required this.questionCategory,

  });
}

// class NavigationEvent extends QuizEvents {
//   final String screenRoute;
//   final String? questionCategory;
//   const NavigationEvent(
//       {required this.screenRoute, required this.questionCategory});
// }
