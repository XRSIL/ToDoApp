// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_notes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 1;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel()
      ..date = fields[0] as String
      ..radio = fields[1] as bool
      ..note = fields[2] as String
      ..radioColor = fields[3] as String
      ..insideRadioColor = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.radio)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.radioColor)
      ..writeByte(4)
      ..write(obj.insideRadioColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
