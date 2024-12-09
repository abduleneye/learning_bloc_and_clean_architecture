import 'package:bloc_clean_arch/quiz_app/offline/domain/quiz_model.dart';

abstract class QuizRepo {
  Future<List<QuizModel>> fetchQuizQuestions({required String questionCategory});
  Future<void> checkAnswer();
  Future<void> nextQuestion();
  Future<void> previousQuestion();
  Future<List<QuizModel>> fetchQuestionFromFireStore({required String questionCategory});
  Future<void> uploadQuestionsToFireStore({required String questionCategory, required String questions});
  Future<void> loadQuestionsFromJsonLocally();
}
