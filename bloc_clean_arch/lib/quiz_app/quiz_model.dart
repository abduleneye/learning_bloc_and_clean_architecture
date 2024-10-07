class QuizModel {
  final String question;
  final Map<String, String> optionA;
  final Map<String, String> optionB;
  final Map<String, String> optionC;
  final Map<String, String> optionD;
  final Map<String, String> correctAns;
  QuizModel(
      {required this.question,
      required this.optionA,
      required this.optionB,
      required this.optionC,
      required this.optionD,
      required this.correctAns});
}
