import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:taste_master_app/src/data/models/api/dog/api_image_dog_model.dart';

part 'api_dog_model.g.dart';

List<ApiDogModel> dogsFromJson(String str) => List<ApiDogModel>.from(
    json.decode(str).map((x) => ApiDogModel.fromJson(x)));

@HiveType(typeId: 2)
class ApiDogModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String bredFor;

  @HiveField(3)
  String breedGroup;

  @HiveField(4)
  String lifeSpan;

  @HiveField(5)
  String temperament;

  @HiveField(6)
  String origin;

  @HiveField(7)
  String referenceImageId;

  @HiveField(8)
  ApiImageDogModel image;

  ApiDogModel({
    required this.id,
    required this.name,
    required this.bredFor,
    required this.breedGroup,
    required this.lifeSpan,
    required this.temperament,
    required this.origin,
    required this.referenceImageId,
    required this.image,
  });

  factory ApiDogModel.fromJson(Map<String, dynamic> json) => ApiDogModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? 'Unknown',
        bredFor: json["bred_for"] ?? 'Unknown',
        breedGroup: json["breed_group"] ?? 'Unknown',
        lifeSpan: json["life_span"] ?? 'Unknown',
        temperament: json["temperament"] ?? 'Unknown',
        origin: json["origin"] ?? 'Unknown',
        referenceImageId: json["reference_image_id"] ?? 'Unknown',
        image: ApiImageDogModel.fromJson(json["image"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bred_for": bredFor,
        "breed_group": breedGroup,
        "life_span": lifeSpan,
        "temperament": temperament,
        "origin": origin,
        "reference_image_id": referenceImageId,
        "image": image.toJson(),
      };
}
