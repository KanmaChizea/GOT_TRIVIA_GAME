import 'package:drift/drift.dart';

part 'got_trivia.g.dart';

class Statistics extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get score => integer()();
  IntColumn get unanswered => integer()();
  DateTimeColumn get date => dateTime()();
}

@DriftDatabase(tables: [Statistics])
class MyDatabase extends _$MyDatabase {}
