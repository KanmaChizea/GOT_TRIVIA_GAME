class Questions {
  String question;
  List<String> answers;
  String correctAnswer;
  String? selectedAnswer;
  Questions({
    required this.question,
    required this.answers,
    required this.correctAnswer,
    this.selectedAnswer,
  });
}
