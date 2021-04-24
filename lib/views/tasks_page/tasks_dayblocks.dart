import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controllers/tasks_page/tasks_dialog_controller.dart';

class DayListView extends StatelessWidget {
  final controller = Get.put(DialogController());
  static const block_title = const Color(0xFF00C98B);
  static const backgroundColor = Color(0xFFA8A8A8);
  @override
  Widget build(BuildContext context) {
    controller.getDaysList(controller.daysList);
    return Container(
        child: Obx(() => (ListView.builder(
            itemCount: controller.daysList.length,
            itemBuilder: (context, index) {
              var marginTop = 20.0;
              if (index == 0) {
                marginTop = 20.0;
              } else {
                marginTop = 0.0;
              }
              return Container(
                margin: EdgeInsets.only(top: marginTop),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(22.5, 0, 22.5, 0),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      controller.daysList[index].date,
                                      style: TextStyle(
                                          color: block_title,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                      child: InkWell(
                                          highlightColor: Colors.white,
                                          splashColor: Colors.white,
                                          onTap: () {},
                                          child: Image.asset(
                                            'lib/images/tasks_page/add_note.png',
                                            height: 32,
                                            width: 32,
                                          ))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 5, 0),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: backgroundColor, width: 0.5),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child:
                                Text('${controller.daysList[index].notes[0]}'),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              );
            }))));
  }
}