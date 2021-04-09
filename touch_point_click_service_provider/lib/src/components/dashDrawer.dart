import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/screens/profile.dart';
import 'package:touch_point_click_service_provider/src/screens/requests.dart';
import 'package:touch_point_click_service_provider/src/screens/schedule.dart';
import 'package:touch_point_click_service_provider/src/screens/services.dart';
import 'package:touch_point_click_service_provider/src/screens/splashScreen.dart';

class DashDrawer extends StatelessWidget {
  final FontWeight normal = FontWeight.normal;
  final OnlineOfflineAppBar onlineOfflineAppBar;

  DashDrawer(this.onlineOfflineAppBar);

  final Color black = Colors.black;

  final List<String> btnNames = [
    "Profile",
    "Offer Promotions",
    "Support",
    "About",
    "Logout"
  ];

  final List<Widget> btnIcons = [
    AppIconsUsed.circularPersonIcon,
    AppIconsUsed.circularStar,
    AppIconsUsed.supportIcon,
    AppIconsUsed.aboutIcon,
    AppIconsUsed.logoutIcon
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return buttonsToDisplay(context, btnNames.elementAt(index),
              btnIcons.elementAt(index), index);
        },
      ),
    );
  }

  Widget buttonsToDisplay(
      BuildContext context, String name, Icon icon, int index) {
    return Column(
      children: [
        index == 0
            ? Container(
                height: 100,
                decoration: new BoxDecoration(color: Colors.blue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30.0,
                            child: Icon(
                              Icons.person,
                              size: 50.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Touchpoint Click Pty(ltd)',
                                style: AppTextStyles.normalBlack(normal, white),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('info@tpclick.co.za',
                                  style: AppTextStyles.normalBlackSmall(
                                      normal, white),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : Container(),
        InkWell(
          onTap: () {
            changeScreen(context, name);
          },
          child: ListTile(
            leading: icon,
            title: Text(
              name,
              style: AppTextStyles.normalBlack(normal, black),
            ),
            trailing: AppIconsUsed.iosForwardArrowRounded,
          ),
        ),
        index.isOdd || index == 4 ? Divider() : Container(),
      ],
    );
  }

  void changeScreen(BuildContext context, String btnClicked) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        // ignore: missing_return
        builder: (context) {
          switch (btnClicked) {
            case "Profile":
              {
                return Profile(onlineOfflineAppBar);
              }
              break;
            case "Offer Promotions":
              {
                return Requests(onlineOfflineAppBar);
              }
              break;
            case "Support":
              {
                return Schedule(onlineOfflineAppBar);
              }
              break;
            case "About":
              {
                return Services(onlineOfflineAppBar);
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
