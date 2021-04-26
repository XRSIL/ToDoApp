import 'package:hive/hive.dart';

part 'tasks_dayblock_model.g.dart';

@HiveType(typeId: 0)
class DayBlock extends HiveObject {
  @HiveField(0)
  String date;

  @HiveField(1)
  List notes;

  @HiveField(2)
  DateTime datetime;
}
