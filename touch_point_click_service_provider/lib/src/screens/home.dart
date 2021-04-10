import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/dashDrawer.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/dashRequests.dart';
import 'package:touch_point_click_service_provider/src/components/requestComp.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';
import 'package:touch_point_click_service_provider/src/models/serviceProvider.dart';
import 'package:touch_point_click_service_provider/src/models/setAndReturnModels.dart';
import 'package:touch_point_click_service_provider/src/models/userRequest.dart';

import 'package:touch_point_click_service_provider/src/screens/profile.dart';
import 'package:touch_point_click_service_provider/src/screens/profile/profileSettings.dart';
import 'package:touch_point_click_service_provider/src/screens/services.dart';
import 'package:touch_point_click_service_provider/src/screens/schedule.dart';
import 'package:touch_point_click_service_provider/src/screens/requests.dart';
import 'package:touch_point_click_service_provider/src/screens/reports.dart';

class Home extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;
  final ServiceProvider serviceProvider;

  Home({this.onlineOfflineAppBar, this.serviceProvider});

  @override
  _HomeState createState() => _HomeState();
}

OnlineOfflineAppBar onlineOfflineAppBar;

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  ServiceProvider _serviceProvider;

  FirebaseAuth auth = FirebaseAuth.instance;

  FontWeight bold = FontWeight.bold;
  FontWeight normal = FontWeight.normal;
  Color black = Colors.black;
  Color white = Colors.white;
  final String currentRequests = "Current Request";
  final String pendingRequests = "Pending Request(s)";

  void initBottomBar() {
    if (widget.onlineOfflineAppBar == null) {
      onlineOfflineAppBar = OnlineOfflineAppBar();
    } else {
      onlineOfflineAppBar = widget.onlineOfflineAppBar;
    }
  }

  void initServiceProvider() {
    if (widget.serviceProvider != null) {
      _serviceProvider = widget.serviceProvider;
    }
  }

  void checkLoggedInUser() {
    if (FirebaseAuth.instance.currentUser != null) {
      User authUser = FirebaseAuth.instance.currentUser;
      print(authUser.uid);
    } else {
      print("No Logged In User");
    }
  }

  @override
  void initState() {
    super.initState();
    initBottomBar();
    initServiceProvider();
    fillUserRequestList();
    checkLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              RequestComp(userRequestList.elementAt(1), onlineOfflineAppBar)
                  .request(context),
            ),
            UtilWidget.stickyHeader(
              pendingRequests,
              getPendingRequests(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: onlineOfflineAppBar,
      drawer: DashDrawer(onlineOfflineAppBar),
    );
  }

/*
  Widget currentPendingHeadings() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int i) {
        return RequestComp.request();
      },
    );
  }*/

  Widget dashGrid() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            gridItem('assets/images/dashboard/request.png', "requests"),
            gridItem('assets/images/dashboard/schedule.png', "schedule"),
          ],
        ),
        Row(
          children: <Widget>[
            gridItem('assets/images/dashboard/services.png', "services"),
            gridItem('assets/images/dashboard/report.png', "reports"),
          ],
        ),
      ],
    );
  }

  List<UserRequest> userRequestList = [];

  void fillUserRequestList() {
    for (int i = 0; i < 10; i++) {
      userRequestList.add(
        SetAndReturnModels.userRequest("$i", "Itumeleng Makhupane",
            "3427 K Section, Botshabelo, 9781", "18 Mar 2021", "16:10", "$i"),
      );
    }
  }

  Widget getPendingRequests() {
    List<Widget> list = [];
    for (int i = 0; i < userRequestList.length; i++) {
      list.add(RequestComp(userRequestList.elementAt(i), onlineOfflineAppBar)
          .request(context));
    }
    return new Column(children: list);
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
                return ProfileSettings(onlineOfflineAppBar);
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

  double deviceWidth, deviceHeight;

  /*double checkForPortrait() {
    MediaQuery.of(context).orientation;
  }*/
  //Determine if its a tablet or not
  double determineDeviceDimensions() {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    if (deviceWidth > deviceHeight) {
      return deviceHeight;
    } else {
      return deviceWidth;
    }
  }

  Widget gridItem(String imageID, String dashTabs) {
    return InkWell(
      onTap: () {
        navToScreen(dashTabs);
      },
      child: Container(
        height: determineDeviceDimensions() * 0.45,
        width: determineDeviceDimensions() * 0.45,
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
        //navToScreen("profile");
        _scaffoldKey.currentState.openDrawer();
      },
      child: UtilWidget.baseCard(
        50,
        Padding(
          padding: const EdgeInsets.all(16.0),
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
              SizedBox(width: 15.0),
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Itumeleng Makhupane", //_serviceProvider.name,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.normalCompanyName(
                            FontWeight.normal, Colors.black),
                      ),
                      Text(
                        /*_serviceProvider.address == "N/A"
                            ? "Address Not Set":*/
                        "3427 K Section, Botshabelo, 9781", //_serviceProvider.address,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.normalBlackSmall(
                            FontWeight.normal, Colors.black),
                      ),
                      companyDetails(
                        "4.0", //"${_serviceProvider.totalRating}",
                        "100", "",
                      ), //"${_serviceProvider.numRated}", ""),
                      Text(
                        "Open Menu Drawer",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.normalBlackSmall(
                            FontWeight.normal, AppColors.appBlueColor),
                      ),
                    ]),
              )
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
                companyRating + " (" + companyRatedNumber + ")",
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.normalBlackSmallSmall(
                    FontWeight.normal, Colors.grey[600])),
          ),
        ],
      ),
    );
  }
}
