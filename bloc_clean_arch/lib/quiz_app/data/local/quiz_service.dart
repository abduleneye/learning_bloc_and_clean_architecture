import 'dart:io';

import '../../domain/quiz_model.dart';

void QuizStart({required String subject}) {
  // List<QuizModel> physicsQuestions = [];
  List<QuizModel> biologyQuestions = [];
  List<QuizModel> mathsQuestions = [];
  if (subject == 'physics'.toLowerCase()) {
    physicsEngine();
  } else if (subject == 'chemistry'.toLowerCase()) {
    chemistryEngine();
  }
}

void physicsEngine() {
  print('Welcome to physics');
  List<QuizModel> physicsQuestions = [];
  physicsQuestions.add(QuizModel(
      question: "(1) What is science?",
      optionA: {'a': '(a) an art'},
      optionB: {'b': '(b) a branch'},
      optionC: {'c': '(c) a base'},
      optionD: {'d': '(d) hey'},
      correctAns: {'correctAns': 'a'}));
  physicsQuestions.add(QuizModel(
      question: "(2) What is science?",
      optionA: {'a': '(a) an art'},
      optionB: {'b': '(b) a branch'},
      optionC: {'c': '(c) a base'},
      optionD: {'d': '(d) hey'},
      correctAns: {'correctAns': 'a'}));

  physicsQuestions.add(QuizModel(
      question: "(3) What is science?",
      optionA: {'a': '(a) an art'},
      optionB: {'b': '(b) a branch'},
      optionC: {'c': '(c) a base'},
      optionD: {'d': '(d) hey'},
      correctAns: {'correctAns': 'a'}));

  for (var i = 0; i < physicsQuestions.length; i++) {
    print('${physicsQuestions[i].question}\n');
    print('${physicsQuestions[i].optionA['a']}');
    print('${physicsQuestions[i].optionB['b']}');
    print('${physicsQuestions[i].optionC['c']}');
    print('${physicsQuestions[i].optionD['d']}');
    print('Type the correct ans:');
    String? correctAns = stdin.readLineSync();
    if (correctAns == physicsQuestions[0].correctAns['correctAns']) {
      print('correct');
    } else {
      print('Wrong');
    }
  }
}

void chemistryEngine() {
  print('Welcome to chemistry');
  List<QuizModel> chemistryQuestions = [];
  chemistryQuestions.add(QuizModel(
    question: '(1) What is a matter?',
    optionA: {'a': '(a) Anything that has weight and occupies space'},
    optionB: {'b': '(b) null'},
    optionC: {'c': '(c) nothing'},
    optionD: {'d': '(d) no ans'},
    correctAns: {'correctAns': 'a'},
  ));

  print('${chemistryQuestions[0].question}');
  print('${chemistryQuestions[0].optionA['a']}');
  print('${chemistryQuestions[0].optionB['b']}');
  print('${chemistryQuestions[0].optionC['c']}');
  print('${chemistryQuestions[0].optionD['d']}');
  print('Type the correct ans:');
  String? correctAns = stdin.readLineSync();
  if (correctAns == chemistryQuestions[0].correctAns['correctAns']) {
    print('correct');
  } else {
    print('Wrong');
  }
}
