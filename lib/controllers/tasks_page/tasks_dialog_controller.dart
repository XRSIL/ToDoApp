import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import '../../models/tasks_dayblock_model.dart';
import '../../models/tasks_notes_model.dart';
import '../settings_page/settings_tasks_controller.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class CurrentNote {
  NoteModel noteInstance;
  int index;
  String text;
  CurrentNote({this.noteInstance, this.index, this.text});
}

class DialogController extends GetxController {
  final TasksSettingsController settingsController =
      Get.put(TasksSettingsController());

  final datetime =
      '${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('d').format(DateTime.now())} ${DateFormat('MMMM').format(DateTime.now()).substring(0, 3)}, ${DateFormat('y').format(DateTime.now())}, ${DateFormat('Hm').format(DateTime.now())}'
          .obs;
  final date =
      '${DateFormat('E').format(DateTime.now())}, ${DateFormat('d').format(DateTime.now())} ${DateFormat('MMMM').format(DateTime.now()).substring(0, 3)}'
          .obs;

  final hiveDateKey = DateTime.now().obs;

  final tasks = [].obs;
  final task = ''.obs;
  final swipeCell = true.obs;

  changeDate(date) => datetime.value =
      '${DateFormat('EEEE').format(date)}, ${DateFormat('d').format(date)} ${DateFormat('MMMM').format(date).substring(0, 3)}, ${DateFormat('y').format(date)}, ${DateFormat('Hm').format(date)}';

  changeDateKey(date) => hiveDateKey.value = date;

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

  clearController() => {
        Future.delayed(const Duration(milliseconds: 1000), () {
          taskInputController.clear();
        })
      };

  static Box<DayBlock> getDayBlocks() => Hive.box<DayBlock>('dayblocks');

  // ignore: missing_return
  Future addDayBlock(String date, List notes, DateTime dateKey) {
    final dayblock = DayBlock()
      ..date = date
      ..notes = notes
      ..datetime = dateKey.toUtc().millisecondsSinceEpoch ~/ 10000;

    final note = NoteModel()
      ..date = 0
      ..radio = false
      ..note = task.value
      ..radioColor = '0xFFB4B4B4'
      ..insideRadioColor = '0xFFFFFFFF'
      ..focus = false;

    final box = DialogController.getDayBlocks();

    if (box.containsKey(dayblock.date) == true) {
      dayblock.notes = box.get(dayblock.date).notes;
      note.date = dayblock.datetime;
      dayblock.notes.add(note);
      box.put(dayblock.datetime, dayblock);
      dayblock.save();
    } else {
      note.date = dayblock.datetime;
      dayblock.notes = [note];
      box.put(dayblock.datetime, dayblock);
      dayblock.save();
    }

    datetime.value =
        '${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('d').format(DateTime.now())} ${DateFormat('MMMM').format(DateTime.now()).substring(0, 3)}, ${DateFormat('y').format(DateTime.now())}, ${DateFormat('Hm').format(DateTime.now())}';
  }

  final daysList = [].obs;

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
      ..note = ''
      ..radioColor = '0xFFB4B4B4'
      ..insideRadioColor = '0xFFFFFFFF'
      ..focus = true;

    final box = DialogController.getDayBlocks();

    final dayblock = box.get(date);
    dayblock.notes.add(note);
    box.put(date, dayblock);
    dayblock.save();
  }

  // Если удалять несколько заметок подряд быстро, то некоторые не удалятся
  void deleteNote(noteInstance, index) {
    final box = DialogController.getDayBlocks();
    final dayblock = box.get(noteInstance.date);
    final updatedList = box.get(noteInstance.date).notes;
    updatedList.removeAt(index);
    dayblock.notes = updatedList;
    box.put(noteInstance.date, dayblock);
    if (updatedList.isEmpty) {
      box.delete(noteInstance.date);
      getDaysList(daysList);
    } else {
      dayblock.save();
    }
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
    if (settingsController.deleteMarkedNotes.value == true) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        updatedList.removeAt(index);
        box.put(noteInstance.date, dayblock);
        dayblock.save();
        getDaysList(daysList);
      });
    }
  }

  final isKeyboardVisible = false.obs;

  void hideTabBar() {
    isKeyboardVisible.value = false;
    KeyboardVisibilityNotification().addNewListener(
      onChange: (isVisible) {
        isKeyboardVisible.value = isVisible;
      },
    );
  }

  final currentNoteTextFieldValue = CurrentNote(text: '').obs;

  changeCurrentNote(noteInstance, index, value) =>
      currentNoteTextFieldValue.value =
          CurrentNote(noteInstance: noteInstance, index: index, text: value);
}
