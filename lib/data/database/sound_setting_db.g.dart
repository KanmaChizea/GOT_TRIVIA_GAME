// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_setting_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioAdapter extends TypeAdapter<Audio> {
  @override
  final int typeId = 0;

  @override
  Audio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Audio()
      ..music = fields[0] as bool
      ..sound = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, Audio obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.music)
      ..writeByte(1)
      ..write(obj.sound);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
