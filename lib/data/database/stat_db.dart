import 'package:got_trivia_game/data/models/questions.dart';
import 'package:hive/hive.dart';
part 'stat_db.g.dart';

@HiveType(typeId: 1)
class StatsData {
  @HiveField(0)
  late int score;
  @HiveField(1)
  late int unanswered;
  @HiveField(2)
  late DateTime date;

  StatsData(
      {required this.score, required this.unanswered, required this.date});

  StatsData.fromQuestions(List<Questions> questionList) {
    int _score = 0;
    int _unanswered = 0;
    for (var i in questionList) {
      if (i.selectedAnswer == i.correctAnswer) {
        _score++;
      }
      if (i.selectedAnswer == null) {
        _unanswered++;
      }
    }
    score = _score;
    unanswered = _unanswered;
    date = DateTime.now();
  }
}
