// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prefs_dog_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrefsDogModelAdapter extends TypeAdapter<PrefsDogModel> {
  @override
  final int typeId = 0;

  @override
  PrefsDogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrefsDogModel(
      id: fields[0] as String?,
      tasteId: fields[1] as String?,
      dog: fields[2] as ApiDogModel?,
    );
  }

  @override
  void write(BinaryWriter writer, PrefsDogModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tasteId)
      ..writeByte(2)
      ..write(obj.dog);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrefsDogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
