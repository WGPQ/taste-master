import 'package:hive/hive.dart';

part 'taste_model.g.dart';

@HiveType(typeId: 1)
class TasteModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String name;

  TasteModel({
    this.id,
    required this.name,
  });
}
