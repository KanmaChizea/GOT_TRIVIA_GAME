import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/services/database/database.dart';

import '../../data/models/questions.dart';
import '../../data/models/results.dart';

class ResultHandlerCubit extends Cubit<Result> {
  ResultHandlerCubit() : super(Result(correct: 0, incorrect: 0, unanswered: 0));

  void processResult(List<Questions> questions) {
    MyDatabase dbase = MyDatabase();

    final result = Result.fromQuestions(questions);
    dbase.addScore(score: result.correct, unanswered: result.unanswered);
    emit(result);
  }
}
