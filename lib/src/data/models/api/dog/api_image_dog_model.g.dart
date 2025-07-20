// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_image_dog_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApiImageDogModelAdapter extends TypeAdapter<ApiImageDogModel> {
  @override
  final int typeId = 3;

  @override
  ApiImageDogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApiImageDogModel(
      id: fields[0] as String,
      width: fields[1] as int,
      height: fields[2] as int,
      url: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ApiImageDogModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.width)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiImageDogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
