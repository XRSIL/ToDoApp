import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/tasks_page/tasks_dialog_controller.dart';
import 'package:flutter/cupertino.dart';

class AddBlockDialog extends StatelessWidget {
  final DialogController controller = Get.put(DialogController());
  @override
  Widget build(BuildContext context) {
    controller.getDaysList(controller.daysList);
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color(0xFFBABABA), width: 0.5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: CupertinoButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Color(0xFF007AFF), fontSize: 17),
                    ),
                    onPressed: () {
                      controller.clearController();
                      controller.changeValue('');
                      Navigator.of(context).pop();
                    },
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'New Task',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: CupertinoButton(
                    child: Text(
                      'Done',
                      style: TextStyle(color: Color(0xFF007AFF), fontSize: 17),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xFFF8F8F8),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFBABABA), width: 0.5),
                          top: BorderSide(
                              color: Color(0xFFBABABA), width: 0.5))),
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: CupertinoTextFormFieldRow(
                    controller: controller.taskInputController,
                    onChanged: (value) {
                      controller.changeValue(value);
                      controller.changeTask(value);
                    },
                    maxLines: null,
                    placeholder: 'Task',
                    keyboardType: TextInputType.multiline,
                    autocorrect: true,
                  ),
                ),
                Center(
                  child: Obx(() => (Text('${controller.text}',
                      style:
                          TextStyle(color: Color(0xFF000000), fontSize: 17)))),
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Center(
                          child: Obx(() => Text(
                                '${controller.datetime.value}',
                                style: TextStyle(
                                    color: Color(0xFF007AFF), fontSize: 17),
                              ))),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: Color(0xFFBABABA), width: 0.5))),
                    ),
                    Container(
                        height: 200,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xFFBABABA), width: 0.5))),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(
                                    color: Color(0xFFBABABA), width: 0.5)),
                          ),
                          child: CupertinoDatePicker(
                            onDateTimeChanged: (DateTime value) {
                              controller.changeDate(value);
                              controller.setDate(value);
                            },
                            initialDateTime: DateTime.now(),
                            use24hFormat: true,
                          ),
                        )),
                    Container(
                      height: 50,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: Color(0xFFBABABA), width: 0.5),
                              bottom: BorderSide(
                                  color: Color(0xFFBABABA), width: 0.5))),
                      child: Center(
                        child: CupertinoButton(
                          child: Text(
                            'Add Task',
                            style: TextStyle(
                                color: Color(0xFF007AFF), fontSize: 17),
                          ),
                          onPressed: () {
                            controller.setTasks(controller.task.value);
                            controller.addDayBlock(
                                '${controller.date.value}', controller.tasks);
                            Navigator.of(context).pop();
                            controller.clearDate();
                            controller.clearController();
                            controller.changeValue('');
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
