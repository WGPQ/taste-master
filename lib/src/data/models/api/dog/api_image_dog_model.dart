import 'package:hive/hive.dart';

part 'api_image_dog_model.g.dart';

@HiveType(typeId: 3)
class ApiImageDogModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  int width;
  @HiveField(2)
  int height;
  @HiveField(3)
  String url;

  ApiImageDogModel({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
  });
  factory ApiImageDogModel.fromJson(Map<String, dynamic> json) =>
      ApiImageDogModel(
        id: json["id"] ?? '',
        width: json["width"] ?? 0,
        height: json["height"] ?? 0,
        url: json["url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
      };
}
