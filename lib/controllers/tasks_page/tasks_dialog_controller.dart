import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  changeDate(date) => datetime.value =
      '${DateFormat('EEEE').format(date)}, ${DateFormat('d').format(date)} ${DateFormat('MMMM').format(date).substring(0, 3)}, ${DateFormat('y').format(date)}, ${DateFormat('Hm').format(date)}';
}

class DialogTextController extends GetxController {
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

  changeValue(input) => text.value = input;

  clearController() => taskInputController.clear();
}
