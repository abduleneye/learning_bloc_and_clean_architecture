import 'package:bloc_clean_arch/quiz_app/domain/quiz_model.dart';

abstract class QuizRepo {
  Future<List<QuizModel>> fetchQuizQuestions({required String category});
  Future<void> checkAnswer();
  Future<void> nextQuestion();
  Future<void> previousQuestion();
}
