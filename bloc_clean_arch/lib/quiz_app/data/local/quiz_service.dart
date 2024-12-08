import 'dart:io';

import '../../domain/quiz_model.dart';

//Intital quiz model data structure
class QuizModelConsole {
  final String question;
  final Map<String, String> optionA;
  final Map<String, String> optionB;
  final Map<String, String> optionC;
  final Map<String, String> optionD;
  final Map<String, String> correctAns;
  QuizModelConsole(
      {required this.question,
      required this.optionA,
      required this.optionB,
      required this.optionC,
      required this.optionD,
      required this.correctAns});

  factory QuizModelConsole.fromJson(Map<dynamic, dynamic> json) {
    return QuizModelConsole(
      question: json['question'],
      optionA: json[{'optionA'}],
      optionB: json[{'optionB'}],
      optionC: json[{'optionC'}],
      optionD: json[{'optionD'}],
      correctAns: json[{'correctAns'}],
    );
  }
}

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
  List<QuizModelConsole> physicsQuestions = [];
  physicsQuestions.add(QuizModelConsole(
      question: "(1) What is science?",
      optionA: {'a': '(a) an art'},
      optionB: {'b': '(b) a branch'},
      optionC: {'c': '(c) a base'},
      optionD: {'d': '(d) hey'},
      correctAns: {'correctAns': 'a'}));
  physicsQuestions.add(QuizModelConsole(
      question: "(2) What is science?",
      optionA: {'a': '(a) an art'},
      optionB: {'b': '(b) a branch'},
      optionC: {'c': '(c) a base'},
      optionD: {'d': '(d) hey'},
      correctAns: {'correctAns': 'a'}));

  physicsQuestions.add(QuizModelConsole(
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
  List<QuizModelConsole> chemistryQuestions = [];
  chemistryQuestions.add(QuizModelConsole(
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
