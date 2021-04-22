import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';

import 'package:touch_point_click_service_provider/src/components/appBarTabs.dart';
import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/requestComp.dart';

import 'package:touch_point_click_service_provider/src/models/userRequest.dart';
import 'package:touch_point_click_service_provider/src/screens/home.dart';

class Requests extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  Requests(this.onlineOfflineAppBar);

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final Color white = Colors.white;

  List<UserRequest> userRequestList = [];

  @override
  void initState() {
    super.initState();
    fillUserRequestList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: BaseWidget.defaultScreen(
        context,
        appBarBackButton(),
        screenBody(),
        AppBarTabs.twoAppBarBottomTabs("Upcoming", "Past"),
        "Requests",
        widget.onlineOfflineAppBar,
        null,
        null,
      ),
    );
  }

  Widget appBarBackButton() {
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
  }

  Widget screenBody() {
    return TabBarView(children: [
      Container(
        child: upcomingRequests(),
      ),
      Container(
        child: pastRequests(),
      )
    ]);
  }

  Widget upcomingRequests() {
    return getRequests();
  }

  Widget pastRequests() {
    return getRequests();
  }

  void fillUserRequestList() {
    for (int i = 0; i < 10; i++) {
      userRequestList.add(
        UserRequest("$i", "Itumeleng Makhupane",
            "3427 K Section, Botshabelo, 9781", "18 Mar 2021", "16:10", "$i"),
      );
    }
  }

  Widget getRequests() {
    List<Widget> list = [];
    for (int i = 0; i < userRequestList.length; i++) {
      list.add(
          RequestComp(userRequestList.elementAt(i), widget.onlineOfflineAppBar)
              .request(context));
    }
    return new ListView(children: list);
  }
}
