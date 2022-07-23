import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:got_trivia_game/data/models/results.dart';
import 'package:hive/hive.dart';

import '../../data/database/stat_db.dart';
import '../../data/models/questions.dart';

class ResultHandlerCubit extends Cubit<Result> {
  ResultHandlerCubit() : super(Result(correct: 0, incorrect: 0, unanswered: 0));

  Box<StatsData> box = Hive.box('stats');

  void processResult(List<Questions> questions) {
    box.add(StatsData.fromQuestions(questions));

    emit(Result.fromQuestions(questions));
  }
}
