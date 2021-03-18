import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/dashRequests.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

import 'package:touch_point_click_service_provider/src/screens/profile.dart';
import 'package:touch_point_click_service_provider/src/screens/services.dart';
import 'package:touch_point_click_service_provider/src/screens/schedule.dart';
import 'package:touch_point_click_service_provider/src/screens/requests.dart';
import 'package:touch_point_click_service_provider/src/screens/reports.dart';

class Home extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  Home({this.onlineOfflineAppBar});

  @override
  _HomeState createState() => _HomeState();
}

OnlineOfflineAppBar onlineOfflineAppBar;

class _HomeState extends State<Home> {
  FontWeight bold = FontWeight.bold;
  FontWeight normal = FontWeight.normal;
  Color black = Colors.black;
  Color white = Colors.white;
  final String currentRequests = "Current Request";
  final String pendingRequests = "Pending Request(s)";

  @override
  void initState() {
    super.initState();
    if (widget.onlineOfflineAppBar == null) {
      onlineOfflineAppBar = OnlineOfflineAppBar();
    } else {
      onlineOfflineAppBar = widget.onlineOfflineAppBar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Dashboard",
          style: AppTextStyles.normalLarge(bold, black),
        ),
        actions: [
          messageNotif(),
          generalNotif(),
        ],
      ),
      body: BaseWidget.clipedBase(
        ListView(
          children: [
            Container(height: 150, child: homeProfile()),
            UtilWidget.baseCard(
                50, lunchBtn()), //Check if user is online, if yes, display
            dashGrid(),
            UtilWidget.stickyHeader(
              currentRequests,
              currentPendingHeadings(
                PendingAccept("4110", "3427 K Section, Botshabelo, 9781",
                    "10 Mar 2021", "16:09"),
              ),
            ),
            UtilWidget.stickyHeader(
              pendingRequests,
              currentPendingHeadings(
                PendingAccept("4111", "3427 K Section, Botshabelo, 9781",
                    "11 Mar 2021", "17:30"),
              ),
            ),
            currentPendingHeadings(
              PendingAccept("4111", "3427 K Section, Botshabelo, 9781",
                  "11 Mar 2021", "17:30"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: onlineOfflineAppBar,
    );
  }

  Widget currentPendingHeadings(Widget requests) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [requests],
    );
  }

  Widget dashGrid() {
    return Container(
      height: 410,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        primary: false,
        children: [
          gridItem('assets/images/dashboard/request.png', "requests"),
          gridItem('assets/images/dashboard/schedule.png', "schedule"),
          gridItem('assets/images/dashboard/services.png', "services"),
          gridItem('assets/images/dashboard/report.png', "reports"),
        ],
      ),
    );
  }

  void navToScreen(String dashTabs) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // ignore: missing_return
        builder: (context) {
          switch (dashTabs) {
            case "profile":
              {
                return Profile();
              }
              break;
            case "requests":
              {
                return Requests(onlineOfflineAppBar);
              }
              break;
            case "schedule":
              {
                return Schedule(onlineOfflineAppBar);
              }
              break;
            case "services":
              {
                return Services(onlineOfflineAppBar);
              }
              break;
            case "reports":
              {
                return Reports(onlineOfflineAppBar);
              }
              break;
          }
        },
      ),
    );
  }

  Widget gridItem(String imageID, String dashTabs) {
    return InkWell(
      onTap: () {
        navToScreen(dashTabs);
      },
      child: Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26, //Color(0x802196F3),
            )
          ],
          image: new DecorationImage(
            image: AssetImage(imageID),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget homeProfile() {
    return InkWell(
      onTap: () {
        navToScreen("profile");
      },
      child: UtilWidget.baseCard(
        50,
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.appBackgroundColor,
                      radius: 40.0,
                      child: new Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 50,
                      ),
                    ),
                    Spacer(flex: 1),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Company Name",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.normalCompanyName(
                                FontWeight.normal, Colors.black),
                          ),
                          Text(
                            "3427 K Section, Botshabelo, 9781",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.normalBlackSmall(
                                FontWeight.normal, Colors.black),
                          ),
                          companyDetails("4.3", "200+", "10"),
                          Text(
                            "View Profile",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.normalBlackSmall(
                                FontWeight.normal, AppColors.appBlueColor),
                          ),
                        ]),
                    Spacer(flex: 2),
                    AppIconsUsed.iosForwardArrowWhite,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget lunchBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Are you starving?",
          style: AppTextStyles.normalBlack(normal, black),
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ElevatedButton(
            onPressed: () {},
            style: UtilWidget.buttonStyle,
            child: Text(
              "Go To Lunch",
              style: AppTextStyles.normalBlack(normal, white),
            ),
          ),
        ),
      ],
    );
  }

  Widget messageNotif() {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: CircleAvatar(
        backgroundColor: AppColors.appBackgroundColor,
        radius: 20,
        child: new IconButton(
            icon: Icon(
              Icons.mail_outline_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              changeScreen();
            }),
      ),
    );
  }

  Widget generalNotif() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 4.0),
      child: CircleAvatar(
        backgroundColor: AppColors.appBackgroundColor,
        radius: 20,
        child: new IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
            onPressed: () {}),
      ),
    );
  }

  void changeScreen() {
    /*Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Draft(),
      ),
    );*/
  }

  Widget companyDetails(
      String companyRating, String companyRatedNumber, String companyDistance) {
    return Container(
      child: Row(
        children: <Widget>[
          AppIconsUsed.greyRatingStar,
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
                //"4.3 (200+) \u00B7 10km away"
                companyRating +
                    " (" +
                    companyRatedNumber +
                    ") \u00B7 " +
                    companyDistance +
                    "km away",
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.normalBlackSmallSmall(
                    FontWeight.normal, Colors.grey[600])),
          ),
        ],
      ),
    );
  }
}
