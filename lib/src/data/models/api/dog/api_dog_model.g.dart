// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_dog_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApiDogModelAdapter extends TypeAdapter<ApiDogModel> {
  @override
  final int typeId = 2;

  @override
  ApiDogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApiDogModel(
      id: fields[0] as int,
      name: fields[1] as String,
      bredFor: fields[2] as String,
      breedGroup: fields[3] as String,
      lifeSpan: fields[4] as String,
      temperament: fields[5] as String,
      origin: fields[6] as String,
      referenceImageId: fields[7] as String,
      image: fields[8] as ApiImageDogModel,
    );
  }

  @override
  void write(BinaryWriter writer, ApiDogModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.bredFor)
      ..writeByte(3)
      ..write(obj.breedGroup)
      ..writeByte(4)
      ..write(obj.lifeSpan)
      ..writeByte(5)
      ..write(obj.temperament)
      ..writeByte(6)
      ..write(obj.origin)
      ..writeByte(7)
      ..write(obj.referenceImageId)
      ..writeByte(8)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiDogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
