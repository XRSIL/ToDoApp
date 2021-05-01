import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import '../../models/tasks_dayblock_model.dart';
import '../../models/tasks_notes_model.dart';
import '../../controllers/tasks_page/tasks_dialog_controller.dart';

class NoteListController extends GetxController {
  final dialogController = Get.put(DialogController());

  void taskToHive(noteInstance, index, value) {
    final box = DialogController.getDayBlocks();
    final dayblock = box.get(noteInstance.date);
    final updatedList = box.get(noteInstance.date).notes;
    updatedList[index].note = value;
    dayblock.notes = updatedList;
    box.put(noteInstance.date, dayblock);
    dayblock.save();
  }
}
