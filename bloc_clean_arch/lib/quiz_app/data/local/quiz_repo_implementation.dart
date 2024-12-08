import 'package:bloc_clean_arch/quiz_app/domain/quiz_model.dart';
import 'package:bloc_clean_arch/quiz_app/domain/quiz_repo.dart';

class QuizRepoImplementation extends QuizRepo {
  @override
  Future<void> checkAnswer() {
    // TODO: implement checkAnswer
    throw UnimplementedError();
  }

  @override
  Future<List<QuizModel>> fetchQuizQuestions({required String category}) async {

    Future<List<QuizModel>> PhysicsQuestions() async {
      print('Welcome to physics');
      List<QuizModel> physicsQuestions = [];
      physicsQuestions.add(QuizModel(
        question: "(1) What is science?",
        allOptions: ['an art', 'a base', 'omo', 'a branch of knowledge'],
        correctOption: 'a branch of knowledge',
      ));
      physicsQuestions.add(QuizModel(
        question: "(2) Who discovered gravity?",
        allOptions: ['albert einstein', 'tony stark', 'nheil bohr', 'issac newton'],
        correctOption: 'issac newton',
      ));

      physicsQuestions.add(QuizModel(
        question: "(3) How many planets do we have?",
        allOptions: ['4', '5', '8', '9'],
        correctOption: '9',
      ));

      return physicsQuestions;
    }

    Future<List<QuizModel>> ChemistryQuestions() async {
      List<QuizModel> chemistryQuestions = [];
      chemistryQuestions.add(QuizModel(
        question: "(1) How many atoms do we have in the periodic table?",
        allOptions: ['0', '345', 'none'],
        correctOption: '225',
      ));
      chemistryQuestions.add(QuizModel(
        question: "(2) What is an ion?",
        allOptions: ['none', 'a substance', 'a cell'],
        correctOption: 'complexes',
      ));

      chemistryQuestions.add(QuizModel(
        question: "(3) what is a salt?",
        allOptions: ['a base', 'holla', 'inredient'],
        correctOption: 'a matter',
      ));

      return chemistryQuestions;
    }

    if (category == 'physics') {
      return PhysicsQuestions();
    } else if (category == 'chemistry') {
      return ChemistryQuestions();
    } else {
      throw Exception('Cant return an empty list');
    }
  }

  @override
  Future<void> nextQuestion() {
    // TODO: implement nextQuestion
    throw UnimplementedError();
  }

  @override
  Future<void> previousQuestion() {
    // TODO: implement previousQuestion
    throw UnimplementedError();
  }
}
