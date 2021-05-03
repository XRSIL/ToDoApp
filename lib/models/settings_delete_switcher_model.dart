import 'package:hive/hive.dart';

part 'settings_delete_switcher_model.g.dart';

@HiveType(typeId: 2)
class DeleteSwitcher extends HiveObject {
  @HiveField(0)
  bool value;
}
