// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Statistic extends DataClass implements Insertable<Statistic> {
  final int id;
  final int score;
  final int unanswered;
  final DateTime date;
  Statistic(
      {required this.id,
      required this.score,
      required this.unanswered,
      required this.date});
  factory Statistic.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Statistic(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      score: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}score'])!,
      unanswered: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unanswered'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['score'] = Variable<int>(score);
    map['unanswered'] = Variable<int>(unanswered);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  StatisticsCompanion toCompanion(bool nullToAbsent) {
    return StatisticsCompanion(
      id: Value(id),
      score: Value(score),
      unanswered: Value(unanswered),
      date: Value(date),
    );
  }

  factory Statistic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Statistic(
      id: serializer.fromJson<int>(json['id']),
      score: serializer.fromJson<int>(json['score']),
      unanswered: serializer.fromJson<int>(json['unanswered']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'score': serializer.toJson<int>(score),
      'unanswered': serializer.toJson<int>(unanswered),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Statistic copyWith({int? id, int? score, int? unanswered, DateTime? date}) =>
      Statistic(
        id: id ?? this.id,
        score: score ?? this.score,
        unanswered: unanswered ?? this.unanswered,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('Statistic(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('unanswered: $unanswered, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, score, unanswered, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Statistic &&
          other.id == this.id &&
          other.score == this.score &&
          other.unanswered == this.unanswered &&
          other.date == this.date);
}

class StatisticsCompanion extends UpdateCompanion<Statistic> {
  final Value<int> id;
  final Value<int> score;
  final Value<int> unanswered;
  final Value<DateTime> date;
  const StatisticsCompanion({
    this.id = const Value.absent(),
    this.score = const Value.absent(),
    this.unanswered = const Value.absent(),
    this.date = const Value.absent(),
  });
  StatisticsCompanion.insert({
    this.id = const Value.absent(),
    required int score,
    required int unanswered,
    required DateTime date,
  })  : score = Value(score),
        unanswered = Value(unanswered),
        date = Value(date);
  static Insertable<Statistic> custom({
    Expression<int>? id,
    Expression<int>? score,
    Expression<int>? unanswered,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (score != null) 'score': score,
      if (unanswered != null) 'unanswered': unanswered,
      if (date != null) 'date': date,
    });
  }

  StatisticsCompanion copyWith(
      {Value<int>? id,
      Value<int>? score,
      Value<int>? unanswered,
      Value<DateTime>? date}) {
    return StatisticsCompanion(
      id: id ?? this.id,
      score: score ?? this.score,
      unanswered: unanswered ?? this.unanswered,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (unanswered.present) {
      map['unanswered'] = Variable<int>(unanswered.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatisticsCompanion(')
          ..write('id: $id, ')
          ..write('score: $score, ')
          ..write('unanswered: $unanswered, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $StatisticsTable extends Statistics
    with TableInfo<$StatisticsTable, Statistic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatisticsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int?> score = GeneratedColumn<int?>(
      'score', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _unansweredMeta = const VerificationMeta('unanswered');
  @override
  late final GeneratedColumn<int?> unanswered = GeneratedColumn<int?>(
      'unanswered', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, score, unanswered, date];
  @override
  String get aliasedName => _alias ?? 'statistics';
  @override
  String get actualTableName => 'statistics';
  @override
  VerificationContext validateIntegrity(Insertable<Statistic> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('unanswered')) {
      context.handle(
          _unansweredMeta,
          unanswered.isAcceptableOrUnknown(
              data['unanswered']!, _unansweredMeta));
    } else if (isInserting) {
      context.missing(_unansweredMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Statistic map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Statistic.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $StatisticsTable createAlias(String alias) {
    return $StatisticsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $StatisticsTable statistics = $StatisticsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [statistics];
}
