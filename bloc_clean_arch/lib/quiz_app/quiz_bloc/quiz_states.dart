import 'package:bloc_clean_arch/quiz_app/quiz_model.dart';

abstract class QuizStates {
  final int currentQ;
  final List<QuizModel> q;
  const QuizStates(this.currentQ, this.q);
}

class QuestionIndex extends QuizStates {
  const QuestionIndex(int index) : super(index, const []);
}
