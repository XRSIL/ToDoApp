import 'package:hive/hive.dart';

part 'tasks_dayblocks.g.dart';

@HiveType(typeId: 0)
class DayBlocks extends HiveObject {
  @HiveField(0)
  String day;

  @HiveField(1)
  String task;

  @HiveField(2)
  String month;

  @HiveField(3)
  List notes;
}
