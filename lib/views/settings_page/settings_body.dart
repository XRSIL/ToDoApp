import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  'Settings Page',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
