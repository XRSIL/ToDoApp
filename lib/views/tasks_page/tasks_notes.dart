import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/tasks_page/tasks_dialog_controller.dart';
import 'package:flutter/cupertino.dart';

class NotesListView extends StatelessWidget {
  final controller = Get.put(DialogController());
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Container(
              child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.daysList.length,
            itemBuilder: (context, index) {
              return Text('data');
            },
          )))
    ]);
  }
}
