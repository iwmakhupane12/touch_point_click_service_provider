import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';

class Requests extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  Requests(this.onlineOfflineAppBar);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      Container(
        child: Center(child: Text("Services")),
      ),
      null,
      "Services",
      widget.onlineOfflineAppBar,
    );
  }
}
