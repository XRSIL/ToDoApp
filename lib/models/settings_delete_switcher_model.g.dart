// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_delete_switcher_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeleteSwitcherAdapter extends TypeAdapter<DeleteSwitcher> {
  @override
  final int typeId = 2;

  @override
  DeleteSwitcher read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeleteSwitcher()..value = fields[0] as bool;
  }

  @override
  void write(BinaryWriter writer, DeleteSwitcher obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteSwitcherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
