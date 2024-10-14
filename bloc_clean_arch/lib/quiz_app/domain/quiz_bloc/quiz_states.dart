import 'package:bloc_clean_arch/quiz_app/quiz_model.dart';

class QuizStates {
  final int currentQ;
  final List<QuizModel> questions;
  final String? currentScreen;
  final String isOptionA;
  final String isOptionB;
  final String isOptionC;
  final String isOptionD;

  const QuizStates(
      {required this.currentQ,
      required this.questions,
      required this.isOptionA,
      required this.isOptionB,
      required this.isOptionC,
      required this.isOptionD,
      required this.currentScreen});
}
