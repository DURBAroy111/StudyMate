import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class SubjectModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int totalClasses;

  @HiveField(2)
  late int attendedClasses;

  @HiveField(3)
  late bool deleteFunction;
}