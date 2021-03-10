import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/components/textShaderMask.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

import 'package:touch_point_click_service_provider/src/screens/home.dart';

class Draft extends StatefulWidget {
  @override
  _DraftState createState() => _DraftState();
}

class _DraftState extends State<Draft> {
  bool _loading = false;
  bool _dismissed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        title: Container(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
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
                            style: AppTextStyles.normalBlack(
                                FontWeight.normal, Colors.white),
                          ),
                          Text(
                            "3427 K Section, Botshabelo, 9781",
                            style: AppTextStyles.normalBlackSmall(
                                FontWeight.normal, Colors.black),
                          ),
                          companyDetails("4.3", "200+", "10"),
                          Text(
                            "View Profile",
                            style: AppTextStyles.normalBlackSmall(
                                FontWeight.normal, Colors.white),
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
      body: BaseWidget.clipedBase(
        ListView(
          children: [
            dashGrid(),
            /*Divider(),
            Text("Pending Request(s)")*/
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.red,
        child: Container(
          height: 50,
          child: !_dismissed ? goOnlineBtn() : goOfflineBtn(),
        ),
      ),
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
          gridItem('assets/images/dashboard/request.png'),
          gridItem('assets/images/dashboard/schedule.png'),
          gridItem('assets/images/dashboard/services.png'),
          gridItem('assets/images/dashboard/report.png'),
        ],
      ),
    );
  }

  Widget gridItem(String imageID) {
    return Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
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
    );
  }

  Widget goOfflineBtn() {
    return Dismissible(
      key: ValueKey(3),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width * 1,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            onPressed: () {
              setState(() {
                //_loading = !_loading;
              });
              UtilWidget.showLoadingDialog(context, "Getting User Data...");
            },
            child: TextShaderMask(
                btnText: "Slide To Go Offline", dismissed: _dismissed),
          ),
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          _dismissed = !_dismissed;
        });
        changeScreen();
      },
      background: Container(alignment: Alignment.center, color: Colors.blue),
    );
  }

  Widget goOnlineBtn() {
    return Dismissible(
      key: ValueKey(2),
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
              UtilWidget.showLoadingDialog(context, "Getting User Data...");
            },
            child: TextShaderMask(
                btnText: "Slide To Go Online", dismissed: _dismissed),
          ),
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          _dismissed = !_dismissed;
        });
        changeScreen();
      },
      background: Container(alignment: Alignment.center, color: Colors.red),
    );
  }

  void changeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  Widget companyDetails(
      String companyRating, String companyRatedNumber, String companyDistance) {
    return Container(
      child: Row(
        children: <Widget>[
          AppIconsUsed.yellowRatingStar,
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
                style: AppTextStyles.normalBlackSmallSmall(
                    FontWeight.normal, Colors.yellow)),
          ),
        ],
      ),
    );
  }
}
