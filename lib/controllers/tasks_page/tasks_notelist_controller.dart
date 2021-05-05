import 'package:get/get.dart';
import 'package:getx_todoapp/models/tasks_notes_model.dart';
import '../../controllers/tasks_page/tasks_dialog_controller.dart';

class NoteListController extends GetxController {
  final dialogController = Get.put(DialogController());

  void taskToHive(noteInstance, index, value, from) {
    final box = DialogController.getDayBlocks();
    if (from == 'from_dayblocks') {
      dialogController.changeCurrentNote(
          NoteModel()..date = noteInstance.datetime, index, value);
    }
    if (from == 'from_notes') {
      dialogController.changeCurrentNote(noteInstance, index, value);
      final dayblock = box.get(noteInstance.date);
      final updatedList = box.get(noteInstance.date).notes;
      if (value != '') {
        updatedList[index].focus = false;
        updatedList[index].note = value;
        dayblock.notes = updatedList;
        box.put(noteInstance.date, dayblock);
        dayblock.save();
      }
    }
  }
}
