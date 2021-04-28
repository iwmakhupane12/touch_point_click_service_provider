import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/screens/home.dart';

class Reports extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  Reports(this.onlineOfflineAppBar);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      _scaffoldKey,
      Container(
        child: Center(child: Text("Reports")),
      ),
      null,
      "Reports",
      widget.onlineOfflineAppBar,
      null,
      null,
    );
  }

  /*Widget appBarBackButton() {
    return InkWell(
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Home(onlineOfflineAppBar: widget.onlineOfflineAppBar),
        ),
      ),
      child: AppIconsUsed.appBarIcon,
    );
  }*/
}
