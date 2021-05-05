import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/tasks_page/tasks_dialog_controller.dart';
import 'package:flutter/cupertino.dart';

class AddBlockDialog extends StatelessWidget {
  final DialogController controller = Get.put(DialogController());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFFBABABA), width: 0.5)),
            ),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 20),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Color(0xFF007AFF), fontSize: 22),
                            ),
                          ),
                          onPressed: () {
                            controller.clearController();
                            controller.changeValue('');
                            Navigator.of(context).pop();
                          },
                        )),
                  ),
                  Center(
                    child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          'New Task',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right: 20),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  color: Color(0xFF007AFF), fontSize: 22),
                            ),
                          ),
                          onPressed: () {
                            controller.setTasks(controller.task.value);
                            controller.addDayBlock('${controller.date.value}',
                                controller.tasks, controller.hiveDateKey.value);
                            controller.getDaysList(controller.daysList);
                            Navigator.of(context).pop();
                            controller.clearDate();
                            controller.clearController();
                            controller.changeValue('');
                          },
                        )),
                  ),
                ],
              ),
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
                            bottom: BorderSide(
                                color: Color(0xFFBABABA), width: 0.5),
                            top: BorderSide(
                                color: Color(0xFFBABABA), width: 0.5))),
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: CupertinoTextFormFieldRow(
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                      controller: controller.taskInputController,
                      onChanged: (value) {
                        controller.changeValue(value);
                        controller.changeTask(value);
                      },
                      maxLines: null,
                      placeholder: 'Task',
                      keyboardType: TextInputType.multiline,
                      autocorrect: true,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  /*
                  Center(
                    child: Obx(() => (Text('${controller.text}',
                        style:
                            TextStyle(color: Color(0xFF000000), fontSize: 17)))),
                  ),*/
                  Column(
                    children: [
                      Container(
                        height: 50,
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Center(
                            child: Obx(() => Text(
                                  '${controller.datetime.value}',
                                  style: TextStyle(
                                      color: Color(0xFF007AFF), fontSize: 20),
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
                                controller.changeDateKey(value);
                                controller.setDate(value);
                              },
                              initialDateTime: DateTime.now(),
                              use24hFormat: true,
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
