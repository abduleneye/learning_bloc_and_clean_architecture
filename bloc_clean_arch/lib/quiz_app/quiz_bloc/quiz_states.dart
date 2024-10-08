import 'package:bloc_clean_arch/quiz_app/quiz_model.dart';

class QuizStates {
  final int currentQ;
  final List<QuizModel> q;
  const QuizStates({required this.currentQ, required this.q});
}
