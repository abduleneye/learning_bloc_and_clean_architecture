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
          optionA: {'a': '(a) an art'},
          optionB: {'b': '(b) a branch of knowledge'},
          optionC: {'c': '(c) a base'},
          optionD: {'d': '(d) hey'},
          correctAns: {'correctAns': '(b) a branch of knowledge'}));
      physicsQuestions.add(QuizModel(
          question: "(2) Who discovered gravity?",
          optionA: {'a': '(a) albert einstein'},
          optionB: {'b': '(b) tony stark'},
          optionC: {'c': '(c) issac newton'},
          optionD: {'d': '(d) nheil bohr'},
          correctAns: {'correctAns': '(c) issac newton'}));

      physicsQuestions.add(QuizModel(
          question: "(3) How many planets do we have?",
          optionA: {'a': '(a) 4'},
          optionB: {'b': '(b) 5'},
          optionC: {'c': '(c) 9'},
          optionD: {'d': '(d) 8'},
          correctAns: {'correctAns': '(d) 8'}));

      return physicsQuestions;
    }

    Future<List<QuizModel>> ChemistryQuestions() async {
      List<QuizModel> chemistryQuestions = [];
      chemistryQuestions.add(QuizModel(
          question: "(1) How many atoms do we have in the periodic table?",
          optionA: {'a': '(a) 225'},
          optionB: {'b': '(b) 345'},
          optionC: {'c': '(c) none'},
          optionD: {'d': '(d) 0'},
          correctAns: {'correctAns': '(a) 225'}));
      chemistryQuestions.add(QuizModel(
          question: "(2) What is an ion?",
          optionA: {'a': '(a) complexes'},
          optionB: {'b': '(b) a substance'},
          optionC: {'c': '(c) a cell'},
          optionD: {'d': '(d) none'},
          correctAns: {'correctAns': '(a) complexes'}));

      chemistryQuestions.add(QuizModel(
          question: "(3) what is a salt?",
          optionA: {'a': '(a) a soluble substance'},
          optionB: {'b': '(b) an insoluble substance'},
          optionC: {'c': '(c) a matter'},
          optionD: {'d': '(d) a and c'},
          correctAns: {'correctAns': '(d) a and c'}));

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
