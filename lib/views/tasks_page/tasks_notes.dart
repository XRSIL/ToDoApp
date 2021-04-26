import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/tasks_page/tasks_dialog_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class NotesListView extends StatefulWidget {
  NotesListView({this.content});

  final List content;

  @override
  _NotesListViewState createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
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
            itemCount: widget.content.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: SwipeActionCell(
                        backgroundColor: Colors.white,
                        key: ObjectKey(widget.content[index].note),
                        performsFirstActionWithFullSwipe: true,
                        trailingActions: <SwipeAction>[
                          SwipeAction(
                              content: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.red,
                                ),
                                width: 130,
                                height: 60,
                                child: OverflowBox(
                                  maxWidth: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Delete',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: (CompletionHandler handler) async {
                                /// await handler(true) : will delete this row
                                ///And after delete animation,setState will called to
                                /// sync your data source with your UI
                                await handler(true);
                                controller.deleteNote();
                              },
                              color: Colors.red),
                        ],
                        child: Row(
                          children: [
                            InkWell(
                              child: Container(
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Color(int.parse(
                                            widget.content[index].radioColor)),
                                        width: 3),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(int.parse(widget
                                              .content[index]
                                              .insideRadioColor)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  height: 36,
                                  width: 36,
                                ),
                              ),
                              onTap: () => {},
                            ),
                            Container(
                              width: 230,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFFBABABA),
                                          width: 0.75))),
                              padding: EdgeInsets.only(top: 15),
                              child: CupertinoTextFormFieldRow(
                                initialValue: widget.content[index].note,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          )))
    ]);
  }
}
