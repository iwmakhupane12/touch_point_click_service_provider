import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';

class PastRequest extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  PastRequest(this.onlineOfflineAppBar);

  @override
  _PastRequestState createState() => _PastRequestState();
}

class _PastRequestState extends State<PastRequest> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text("Past")));
  }
}
