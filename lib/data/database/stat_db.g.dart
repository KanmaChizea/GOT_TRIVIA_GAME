// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatsDataAdapter extends TypeAdapter<StatsData> {
  @override
  final int typeId = 1;

  @override
  StatsData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatsData(
      score: fields[0] as int,
      unanswered: fields[1] as int,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, StatsData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.score)
      ..writeByte(1)
      ..write(obj.unanswered)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatsDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
