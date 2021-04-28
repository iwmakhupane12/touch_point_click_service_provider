import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';

import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

class BaseWidget {
  static Widget clipedBase(Widget display) {
    return UtilWidget.clipRectForApp(
      Container(
        color: AppColors.appBackgroundColor,
        child: display,
      ),
    );
  }

  static Widget appBarBackButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      onTap: () => Navigator.pop(context),
      child: AppIconsUsed.appBarIcon,
    );
  }

  static Widget defaultScreen(
    BuildContext context,
    Key scaffoldKey,
    Widget displayBody,
    Widget bottomWidget,
    String appBarTitle,
    Widget bottomNavBarWidget,
    FloatingActionButton floatingActionButton,
    List<Widget> actions,
  ) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: appBarBackButton(context),
        title: Text(
          appBarTitle,
          style: AppTextStyles.normalBlack(FontWeight.normal, Colors.black),
        ),
        bottom: bottomWidget,
        actions: actions,
      ),
      body: BaseWidget.clipedBase(
        displayBody,
      ),
      bottomNavigationBar: bottomNavBarWidget,
      floatingActionButton: floatingActionButton,
    );
  }

  static Widget defaultScreenNoCurve(
      BuildContext context,
      Widget displayBody,
      Widget bottomWidget,
      String appBarTitle,
      Widget bottomNavBarWidget,
      bool toHome) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: appBarBackButton(context),
        title: Text(
          appBarTitle,
          style: AppTextStyles.normalBlack(FontWeight.normal, Colors.black),
        ),
        bottom: bottomWidget,
      ),
      body: displayBody,
      bottomNavigationBar: bottomNavBarWidget,
    );
  }
}
