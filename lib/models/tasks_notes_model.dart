import 'package:hive/hive.dart';

part 'tasks_notes_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  @HiveField(0)
  String date;
  @HiveField(1)
  bool radio;
  @HiveField(2)
  String note;
  @HiveField(3)
  String radioColor;
  @HiveField(4)
  String insideRadioColor;
  @HiveField(5)
  bool focus;
}
