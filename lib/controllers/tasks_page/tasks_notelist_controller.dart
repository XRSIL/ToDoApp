import 'package:get/get.dart';
import '../../controllers/tasks_page/tasks_dialog_controller.dart';

class NoteListController extends GetxController {
  final dialogController = Get.put(DialogController());

  void taskToHive(noteInstance, index, value) {
    final box = DialogController.getDayBlocks();
    final dayblock = box.get(noteInstance.date);
    final updatedList = box.get(noteInstance.date).notes;
    updatedList[index].focus = false;
    updatedList[index].note = value;
    dialogController.changeCurrentNote(noteInstance, index, value);
    dayblock.notes = updatedList;
    box.put(noteInstance.date, dayblock);
    dayblock.save();
  }
}
