import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import '../../models/tasks_dayblock_model.dart';

class EachNote {
  bool radio;
  String note;
  Color radioColor;
  Color insideRadioColor;

  EachNote({this.radio, this.note, this.radioColor, this.insideRadioColor});
}

class DialogController extends GetxController {
  final datetime =
      '${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('d').format(DateTime.now())} ${DateFormat('MMMM').format(DateTime.now()).substring(0, 3)}, ${DateFormat('y').format(DateTime.now())}, ${DateFormat('Hm').format(DateTime.now())}'
          .obs;
  final date =
      '${DateFormat('E').format(DateTime.now())}, ${DateFormat('d').format(DateTime.now())} ${DateFormat('MMMM').format(DateTime.now()).substring(0, 3)}'
          .obs;

  final tasks = [].obs;
  final task = ''.obs;

  changeDate(date) => datetime.value =
      '${DateFormat('EEEE').format(date)}, ${DateFormat('d').format(date)} ${DateFormat('MMMM').format(date).substring(0, 3)}, ${DateFormat('y').format(date)}, ${DateFormat('Hm').format(date)}';

  setDate(input) => date.value =
      '${DateFormat('E').format(input)}, ${DateFormat('d').format(input)} ${DateFormat('MMMM').format(input).substring(0, 3)}';

  changeTask(input) => task.value = input;

  setTasks(input) => tasks.add(input);

  clearDate() => task.value = '';

  TextEditingController taskInputController;

  @override
  void onInit() {
    taskInputController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    taskInputController?.dispose();
    super.onClose();
  }

  final text = ''.obs;

  changeValue(input) => text.value = input; // Need to delete this method later

  clearController() => taskInputController.clear();

  static Box<DayBlock> getDayBlocks() => Hive.box<DayBlock>('dayblocks');

  // ignore: missing_return
  Future addDayBlock(String date, List notes) {
    final dayblock = DayBlock()
      ..date = date
      ..notes = notes;

    final box = DialogController.getDayBlocks();

    if (box.containsKey(dayblock.date) == true) {
      dayblock.notes = box.get(dayblock.date).notes;
      dayblock.notes.add(task.value);
      box.put(dayblock.date, dayblock);
      dayblock.save();
    } else {
      dayblock.notes = [task.value];
      box.put(dayblock.date, dayblock);
      dayblock.save();
    }

    datetime.value =
        '${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('d').format(DateTime.now())} ${DateFormat('MMMM').format(DateTime.now()).substring(0, 3)}, ${DateFormat('y').format(DateTime.now())}, ${DateFormat('Hm').format(DateTime.now())}';
  }

  var daysList = [].obs;

  void getDaysList(input) {
    final box = DialogController.getDayBlocks();

    input = box.values.toList();
    daysList.value = input;
  }
}
