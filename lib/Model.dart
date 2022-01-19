import 'package:hive/hive.dart';
part 'Model.g.dart';

@HiveType(typeId: 0)
class InfoModel {
  @HiveField(0)
  final name;
  @HiveField(1)
  final age;

  InfoModel(this.name, this.age);
}
