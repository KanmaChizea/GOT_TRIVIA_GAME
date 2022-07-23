import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:got_trivia_game/data/database/stat_db.dart';
import 'package:got_trivia_game/data/models/questions.dart';
import 'package:got_trivia_game/main.dart';
import 'package:hive/hive.dart';

part 'stats_state.dart';

class StatsCubit extends Cubit<StatsState> {
  StatsCubit() : super(StatsInitial());

  Box<StatsData> box = Hive.box('stats');

  void deleteStats() async {
    await box.clear();
    getStats();
  }

  getStats() {
    print(box.values);
    if (box.values.isNotEmpty) {
      emit(StatsLoaded(stats: box.values.toList()));
    } else {
      emit(NoStats());
    }
  }
}
