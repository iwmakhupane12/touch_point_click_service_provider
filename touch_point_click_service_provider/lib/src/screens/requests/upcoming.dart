import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';

class UpcomingRequest extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  UpcomingRequest(this.onlineOfflineAppBar);

  @override
  _UpcomingRequestState createState() => _UpcomingRequestState();
}

class _UpcomingRequestState extends State<UpcomingRequest> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text("Upcoming")));
  }
}
