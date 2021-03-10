import 'package:flutter/material.dart';
import 'dart:async';

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
          width: MediaQuery.of(context).size.width * 1,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            onPressed: () {},
            child: TextShaderMask(
                btnText: "Slide To Go Offline", dismissed: _dismissed),
          ),
        ),
      ),
      onDismissed: (direction) {
        btnPressed("Offline");
      },
      background: Container(alignment: Alignment.center, color: Colors.blue),
    );
  }

  Widget goOnlineBtn() {
    return Dismissible(
      key: ValueKey(4),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width * 1,
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            onPressed: () {
              setState(() {
                //_loading = !_loading;
              });
            },
            child: TextShaderMask(
                btnText: "Slide To Go Online", dismissed: _dismissed),
          ),
        ),
      ),
      onDismissed: (direction) {
        btnPressed("Online");
      },
      background: Container(alignment: Alignment.center, color: Colors.red),
    );
  }

  void btnPressed(String status) {
    UtilWidget.showLoadingDialog(context, "Going $status...");
    Timer(Duration(seconds: 5), () {
      Navigator.pop(context);

      setState(() {
        _dismissed = !_dismissed;
      });
      userChangedStatus("Online");
    });
  }

  Widget userChangedStatus(String status) {
    return SnackBar(
      content: Text("You are now $status"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {}, //Update User Status in the database
      ),
    );
  }
}
