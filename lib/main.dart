import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getx_todoapp/controllers/tasks_page/tasks_dialog_controller.dart';
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
// By default when text input is active bottom tab bar appears to be above the keyboard
// To fix this i used this solution
// https://stackoverflow.com/questions/56229036/how-to-hide-cupertinotabbar-when-keyboard-is-displayed-or-how-to-make-keyboard
// But implemented it according to my project; structure

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
      if (tasksSwipeCellController.currentNoteTextFieldValue.value.text == '') {
        tasksSwipeCellController.deleteNote(
            tasksSwipeCellController
                .currentNoteTextFieldValue.value.noteInstance,
            tasksSwipeCellController.currentNoteTextFieldValue.value.index);
      }
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
  final DialogController controller = Get.put(DialogController());

  @override
  Widget build(BuildContext context) {
    controller.hideTabBar();
    return Obx(
      () => CupertinoTabScaffold(
        tabBar: controller.isKeyboardVisible.value
            ? InvisibleCupertinoTabBar()
            : CupertinoTabBar(
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
      ),
    );
  }
}

class InvisibleCupertinoTabBar extends CupertinoTabBar {
  static const dummyIcon = Icon(IconData(0x0020));

  InvisibleCupertinoTabBar()
      : super(
          items: [
            BottomNavigationBarItem(icon: dummyIcon),
            BottomNavigationBarItem(icon: dummyIcon),
          ],
        );

  @override
  Size get preferredSize => const Size.square(0);

  @override
  Widget build(BuildContext context) => SizedBox(height: 0);

  @override
  InvisibleCupertinoTabBar copyWith({
    Key key,
    List<BottomNavigationBarItem> items,
    Color backgroundColor,
    Color activeColor,
    Color inactiveColor,
    double iconSize,
    Border border,
    int currentIndex,
    ValueChanged<int> onTap,
  }) =>
      InvisibleCupertinoTabBar();
}
