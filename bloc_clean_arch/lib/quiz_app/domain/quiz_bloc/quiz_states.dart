import 'package:bloc_clean_arch/quiz_app/quiz_model.dart';

class QuizStates {
  final int currentQ;
  final List<QuizModel> questions;
  final String? currentScreen;
  const QuizStates(
      {required this.currentQ,
      required this.questions,
      required this.currentScreen});
}
