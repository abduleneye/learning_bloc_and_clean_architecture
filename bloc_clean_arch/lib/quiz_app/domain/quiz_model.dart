class QuizModel {
  final String question;
  final List<String> allOptions;
  final String correctOption;

  QuizModel({
    required this.question,
    required this.allOptions,
    required this.correctOption,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
        question: json['question'],
        allOptions: json['incorrectOtions'],
        correctOption: json['correctOption']);
  }
}

//Intital quiz model data structure
// class QuizModel {
//   final String question;
//   final Map<String, String> optionA;
//   final Map<String, String> optionB;
//   final Map<String, String> optionC;
//   final Map<String, String> optionD;
//   final Map<String, String> correctAns;
//   QuizModel(
//       {required this.question,
//       required this.optionA,
//       required this.optionB,
//       required this.optionC,
//       required this.optionD,
//       required this.correctAns});

//   factory QuizModel.fromJson(Map<dynamic, dynamic> json) {
//     return QuizModel(
//       question: json['question'],
//       optionA: json[{'optionA'}],
//       optionB: json[{'optionB'}],
//       optionC: json[{'optionC'}],
//       optionD: json[{'optionD'}],
//       correctAns: json[{'correctAns'}],
//     );
//   }
// }
