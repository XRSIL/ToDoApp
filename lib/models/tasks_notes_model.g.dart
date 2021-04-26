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
      ..radio = fields[0] as bool
      ..note = fields[1] as String
      ..radioColor = fields[2] as String
      ..insideRadioColor = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.radio)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.radioColor)
      ..writeByte(3)
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
