import 'package:get/get.dart';
import 'package:getx_todoapp/models/settings_delete_switcher_model.dart';
import 'package:hive/hive.dart';

class TasksSettingsController extends GetxController {
  final deleteMarkedNotes = false.obs;

  void getSwitcherValue() {
    final box = Hive.box<DeleteSwitcher>('settings_tasks');

    if (box.get(1) == null) {
      deleteMarkedNotes.value = false;
    } else {
      deleteMarkedNotes.value = box.get(1).value;
    }
  }

  static Box<DeleteSwitcher> getDeleteSwitcher() =>
      Hive.box<DeleteSwitcher>('settings_tasks');

  void switcher(value) {
    deleteMarkedNotes.value = value;
    final box = Hive.box<DeleteSwitcher>('settings_tasks');

    final switchValue = DeleteSwitcher()..value = deleteMarkedNotes.value;

    box.put(1, switchValue);
  }
}
