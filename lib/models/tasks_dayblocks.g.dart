// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_dayblocks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayBlocksAdapter extends TypeAdapter<DayBlocks> {
  @override
  final int typeId = 0;

  @override
  DayBlocks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayBlocks()
      ..day = fields[0] as String
      ..task = fields[1] as String
      ..month = fields[2] as String
      ..notes = (fields[3] as List)?.cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, DayBlocks obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.task)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayBlocksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
