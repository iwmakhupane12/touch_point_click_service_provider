import 'package:flutter/material.dart';
import 'dart:async';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/components/textShaderMask.dart';

class OnlineOfflineAppBar extends StatefulWidget {
  @override
  _OnlineOfflineAppBarState createState() => _OnlineOfflineAppBarState();
}

bool _dismissed = false;

class _OnlineOfflineAppBarState extends State<OnlineOfflineAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: Container(
        height: 50,
        child: !_dismissed ? goOnlineBtn() : goOfflineBtn(),
      ),
    );
  }

  Widget goOfflineBtn() {
    return Dismissible(
      key: ValueKey(5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50.0,
          color: Colors.red,
          width: MediaQuery.of(context).size.width * 1,
          child: TextShaderMask(
              btnText: "Slide To Go Offline", dismissed: _dismissed),
        ),
      ),
      onDismissed: (direction) {
        btnPressed("Offline");
      },
      background: Container(
          alignment: Alignment.center, color: AppColors.appBackgroundColor),
    );
  }

  Widget goOnlineBtn() {
    return Dismissible(
      key: ValueKey(4),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50.0,
          color: Colors.blue,
          width: MediaQuery.of(context).size.width * 1,
          child: TextShaderMask(
              btnText: "Slide To Go Online", dismissed: _dismissed),
        ),
      ),
      onDismissed: (direction) {
        btnPressed("Online");
      },
      background: Container(
          alignment: Alignment.center, color: AppColors.appBackgroundColor),
    );
  }

  void btnPressed(String status) {
    UtilWidget.showLoadingDialog(context, "Going $status...");
    Timer(Duration(seconds: 5), () {
      Navigator.pop(context);

      setState(() {
        _dismissed = !_dismissed;
      });
      userChangedStatus(status);
    });
  }

  void userChangedStatus(String status) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("You are now $status"),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {}, //Update User Status in the database
        ),
      ),
    );
  }
}
