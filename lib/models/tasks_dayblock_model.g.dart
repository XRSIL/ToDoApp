// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_dayblock_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayBlockAdapter extends TypeAdapter<DayBlock> {
  @override
  final int typeId = 0;

  @override
  DayBlock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayBlock()
      ..date = fields[0] as String
      ..notes = (fields[1] as List)?.cast<dynamic>()
      ..datetime = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, DayBlock obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.notes)
      ..writeByte(2)
      ..write(obj.datetime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayBlockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
