import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'tasks_dialog.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        color: Color(0xFFF8F8F8),
        child: Column(
          children: [
            Expanded(
              child: Center(child: (Text('f'))),
            )
          ],
        ),
      ),
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        middle: Text(
          'Your tasks',
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        trailing: Container(
          margin: EdgeInsets.only(right: 15),
          child: IconButton(
            icon: Image.asset(
              'lib/images/tasks_page/add_day_button.png',
              height: 32,
              width: 32,
            ),
            onPressed: () {
              showCupertinoModalBottomSheet(
                  isDismissible: true,
                  expand: true,
                  context: context,
                  builder: (context) => AddBlockDialog());
            },
            splashRadius: 20,
          ),
        ),
        border:
            Border(bottom: BorderSide(color: Color(0xFFBABABA), width: 0.5)),
      ),
    );
  }
}
