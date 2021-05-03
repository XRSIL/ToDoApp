import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import '../../controllers/settings_page/settings_tasks_controller.dart';

class SettingsPage extends StatelessWidget {
  final TasksSettingsController controller = Get.put(TasksSettingsController());
  @override
  Widget build(BuildContext context) {
    controller.getSwitcherValue();
    return Center(
        child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        middle: Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        border:
            Border(bottom: BorderSide(color: Color(0xFFBABABA), width: 0.5)),
      ),
      child: Container(
        color: Color(0xFFF8F8F8),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    top: BorderSide(
                                        color: Color(0xFFBABABA), width: 0.5),
                                    bottom: BorderSide(
                                        color: Color(0xFFBABABA), width: 0.5))),
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Delete Marked Notes',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Obx(() => CupertinoSwitch(
                                      value: controller.deleteMarkedNotes.value,
                                      onChanged: (value) =>
                                          (controller.switcher(value)))),
                                )
                              ],
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
        ),
      ),
    ));
  }
}
