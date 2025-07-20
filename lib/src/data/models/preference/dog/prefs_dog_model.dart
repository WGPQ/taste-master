import 'package:hive/hive.dart';
import 'package:taste_master_app/src/data/models/models.dart';

part 'prefs_dog_model.g.dart';

@HiveType(typeId: 0)
class PrefsDogModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? tasteId;

  @HiveField(2)
  ApiDogModel? dog;

  PrefsDogModel({
    this.id,
    required this.tasteId,
    required this.dog,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tasteId': tasteId,
      'dog': dog?.toJson(),
    };
  }
}
