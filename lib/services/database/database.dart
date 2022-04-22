import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Statistics extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get score => integer()();
  IntColumn get unanswered => integer()();
  DateTimeColumn get date => dateTime()();
}

@DriftDatabase(tables: [Statistics])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Statistic>> getScores() async {
    return await (select(statistics)
          ..orderBy([
            (t) => OrderingTerm.desc(t.score),
            (t) => OrderingTerm.asc(t.unanswered)
          ]))
        .get();
  }

  Future<int> addScore({required int score, required int unanswered}) async {
    return await into(statistics).insert(StatisticsCompanion(
        score: Value(score),
        unanswered: Value(unanswered),
        date: Value(DateTime.now())));
  }

  Future<int> deleteStats() async {
    return await delete(statistics).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
