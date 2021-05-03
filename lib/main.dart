import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getx_todoapp/controllers/settings_page/settings_tasks_controller.dart';
import 'views/tasks_page/tasks_body.dart';
import 'views/settings_page/settings_body.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'models/tasks_dayblock_model.dart';
import 'models/tasks_notes_model.dart';
import 'models/settings_delete_switcher_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controllers/tasks_page/tasks_dialog_controller.dart';

// !! NOTE !!
// If date is already in database, then add task to already existing block

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DayBlockAdapter());
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(DeleteSwitcherAdapter());

  await Hive.openBox<DayBlock>('dayblocks');
  await Hive.openBox<DeleteSwitcher>('settings_tasks');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final tasksSwipeCellController = Get.put(DialogController());

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
      tasksSwipeCellController.activateSwipeCell();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      builder: (context, child) => Scaffold(
        // Global GestureDetector that will dismiss the keyboard
        body: GestureDetector(
          onTap: () {
            // When running in iOS, dismiss the keyboard when any Tap happens outside a TextField
            if (Platform.isIOS) hideKeyboard(context);
          },
          child: child,
        ),
      ),
      home: ViewsHandler(),
    );
  }
}

class ViewsHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        iconSize: 30.0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bars), label: 'Settings')
        ],
      ),
      tabBuilder: (context, i) {
        if (i == 0) {
          return TasksPage();
        }
        if (i == 1) {
          return SettingsPage();
        } else {
          return Container(
            child: Center(child: Text('Error Occured')),
          );
        }
      },
      backgroundColor: Colors.white,
    );
  }
}
