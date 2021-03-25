import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/screens/profile.dart';
import 'package:touch_point_click_service_provider/src/screens/requests.dart';
import 'package:touch_point_click_service_provider/src/screens/schedule.dart';
import 'package:touch_point_click_service_provider/src/screens/services.dart';
import 'package:touch_point_click_service_provider/src/screens/splashScreen.dart';

class ProfileSettings extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  ProfileSettings(this.onlineOfflineAppBar);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final FontWeight normal = FontWeight.normal;

  final Color black = Colors.black;

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(context, displayBody(), null,
        "Account Settings", widget.onlineOfflineAppBar, null, null);
  }

  Widget buttonsToDisplay(String name, Icon icon) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: UtilWidget.baseCard(
          null,
          ListTile(
            leading: AppIconsUsed.circularPersonIcon,
            title: Text(
              "Profile",
              style: AppTextStyles.normalBlack(normal, black),
            ),
            trailing: AppIconsUsed.iosForwardArrowRounded,
          ),
        ),
      ),
    );
  }

  Widget displayBody() {
    List<Widget> display = [];
    for (int i = 0; i < 5; i++) {
      display
          .add(buttonsToDisplay(btnNames.elementAt(i), btnIcons.elementAt(i)));
    }
    return ListView(children: display);
  }

  List<String> btnNames = [
    "Profile",
    "Offer Promotions",
    "Support",
    "About",
    "Logout"
  ];

  List<Widget> btnIcons = [
    AppIconsUsed.circularPersonIcon,
    AppIconsUsed.circularStar,
    AppIconsUsed.supportIcon,
    AppIconsUsed.aboutIcon,
    AppIconsUsed.logoutIcon
  ];

  void changeScreen(String btnClicked) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        // ignore: missing_return
        builder: (context) {
          switch (btnClicked) {
            case "Profile":
              {
                return Profile(widget.onlineOfflineAppBar);
              }
              break;
            case "Offer Promotions":
              {
                return Requests(widget.onlineOfflineAppBar);
              }
              break;
            case "Support":
              {
                return Schedule(widget.onlineOfflineAppBar);
              }
              break;
            case "About":
              {
                return Services(widget.onlineOfflineAppBar);
              }
              break;
            case "Logout":
              {
                return SplashScreen();
              }
              break;
          }
        },
      ),
    );
  }
}
