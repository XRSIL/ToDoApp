import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import '../../models/tasks_dayblock_model.dart';
import '../../models/tasks_notes_model.dart';

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
  final swipeCell = true.obs;

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
      ..notes = notes
      ..datetime = DateTime.now();

    final note = NoteModel()
      ..date = ''
      ..radio = false
      ..note = task.value
      ..radioColor = '0xFFB4B4B4'
      ..insideRadioColor = '0xFFFFFFFF';

    final box = DialogController.getDayBlocks();

    if (box.containsKey(dayblock.date) == true) {
      dayblock.notes = box.get(dayblock.date).notes;
      note.date = dayblock.date;
      dayblock.notes.add(note);
      box.put(dayblock.date, dayblock);
      dayblock.save();
    } else {
      note.date = dayblock.date;
      dayblock.notes = [note];
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

  void disposeSwipeCell() {
    swipeCell.value = false;
  }

  void activateSwipeCell() {
    swipeCell.value = true;
  }

  void addNote(date) {
    final note = NoteModel()
      ..date = date
      ..radio = false
      ..note = 'ergerer'
      ..radioColor = '0xFFB4B4B4'
      ..insideRadioColor = '0xFFFFFFFF';

    final box = DialogController.getDayBlocks();

    final dayblock = box.get(date);
    final updatedList = box.get(date).notes;
    updatedList.add(note);
    dayblock.notes = updatedList;
    box.put(date, dayblock);
    dayblock.save();
    getDaysList(daysList);
  }

  // Если удалять несколько заметок подряд быстро, то некоторые не удалятся
  void deleteNote(noteInstance, index) {
    final box = DialogController.getDayBlocks();
    final dayblock = box.get(noteInstance.date);
    final updatedList = box.get(noteInstance.date).notes;
    updatedList.removeAt(index);
    dayblock.notes = updatedList;
    box.put(noteInstance.date, dayblock);
    dayblock.save();
    getDaysList(daysList);
  }

  void radioButtonStateChanger(noteInstance, index) {
    final box = DialogController.getDayBlocks();
    final dayblock = box.get(noteInstance.date);
    final updatedList = box.get(noteInstance.date).notes;
    if (updatedList[index].radio == true) {
      updatedList[index].radio = false;
      updatedList[index].radioColor = '0xFFB4B4B4';
      updatedList[index].insideRadioColor = '0xFFFFFFFF';
    } else {
      updatedList[index].radio = true;
      updatedList[index].radioColor = '0xFF6F84D9';
      updatedList[index].insideRadioColor = '0xFF6F84D9';
    }
    dayblock.notes = updatedList;
    box.put(noteInstance.date, dayblock);
    dayblock.save();
    getDaysList(daysList);
  }
}
