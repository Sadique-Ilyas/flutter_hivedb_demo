// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InfoModelAdapter extends TypeAdapter<InfoModel> {
  @override
  final int typeId = 0;

  @override
  InfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InfoModel(
      fields[0] as dynamic,
      fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, InfoModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
