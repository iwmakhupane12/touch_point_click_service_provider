import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

import 'package:touch_point_click_service_provider/src/screens/home.dart';

class BaseWidget {
  static Widget clipedBase(Widget display) {
    return UtilWidget.clipRectForApp(
      Container(
        color: AppColors.appBackgroundColor,
        child: display,
      ),
    );
  }

  static Widget defaultScreen(
      BuildContext context,
      Widget displayBody,
      Widget bottomWidget,
      String appBarTitle,
      OnlineOfflineAppBar onlineOfflineAppBar) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Home(onlineOfflineAppBar: onlineOfflineAppBar),
            ),
          ),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          appBarTitle,
          style: AppTextStyles.normalBlack(FontWeight.normal, Colors.black),
        ),
        bottom: bottomWidget,
      ),
      body: BaseWidget.clipedBase(
        displayBody,
      ),
      bottomNavigationBar: onlineOfflineAppBar,
    );
  }

  static Widget defaultScreenNoCurve(
      BuildContext context,
      Widget displayBody,
      Widget bottomWidget,
      String appBarTitle,
      OnlineOfflineAppBar onlineOfflineAppBar) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Home(onlineOfflineAppBar: onlineOfflineAppBar),
            ),
          ),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          appBarTitle,
          style: AppTextStyles.normalBlack(FontWeight.normal, Colors.black),
        ),
        bottom: bottomWidget,
      ),
      body: displayBody,
      bottomNavigationBar: onlineOfflineAppBar,
    );
  }
}
