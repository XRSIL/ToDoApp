import 'package:hive/hive.dart';

part 'tasks_notes_model.g.dart';

@HiveType(typeId: 1)
class NoteModel extends HiveObject {
  @HiveField(0)
  bool radio;
  @HiveField(1)
  String note;
  @HiveField(2)
  String radioColor;
  @HiveField(3)
  String insideRadioColor;
}
