import 'package:got_trivia_game/data/models/questions.dart';

class Result {
  late final int correct;
  late final int incorrect;
  late final int unanswered;
  late final String message;
  Result(
      {required this.correct,
      required this.incorrect,
      required this.unanswered,
      message = ''});

  Result.fromQuestions(List<Questions> questions) {
    int correct = 0;
    int incorrect = 0;
    int unanswered = 0;
    String message = '';

    for (var i in questions) {
      if (i.selectedAnswer == null) {
        unanswered++;
      } else if (i.correctAnswer == i.selectedAnswer) {
        correct++;
      } else {
        incorrect++;
      }
    }
    if (correct < 4) {
      message = 'Did you even watch this show';
    } else if (correct >= 4 && correct < 8) {
      message = 'Nice attempt or whatever';
    } else {
      message = 'Boss or God level or whatever sha';
    }
    this.correct = correct;
    this.incorrect = incorrect;
    this.unanswered = unanswered;
    this.message = message;
  }
}
