import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/models/setAndReturnModels.dart';
import 'package:touch_point_click_service_provider/src/models/userService.dart';
import 'package:touch_point_click_service_provider/src/screens/services/serviceDetails.dart';

class Services extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  Services(this.onlineOfflineAppBar);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;

  final Color black = Colors.black;
  final Color white = Colors.white;
  final Color blue = Colors.blue;

  List<UserService> userServiceList = [];
  List<bool> categoryBoolExpandedList = [];
  List<String> categoriesList = [];

  void initCategories() {
    categoriesList.add("Any");
    for (int i = 0; i < userServiceList.length; i++) {
      //Checks if the category is already in the list and if not, add it
      if (!categoriesList
          .contains(userServiceList.elementAt(i).getCategory())) {
        categoriesList.add(userServiceList.elementAt(i).getCategory());
        categoryBoolExpandedList.add(false); //Initialising
      }
    }
  }

  void initScheduleListData() {
    //Category 1
    userServiceList.add(
      SetAndReturnModels.userService(
          "1", "Sciences", "Mathematics", "200", "60"),
    );
    userServiceList.add(
      SetAndReturnModels.userService(
          "2", "Sciences", "Physical Sciences", "180", "60"),
    );
    userServiceList.add(
      SetAndReturnModels.userService(
          "3", "Sciences", "Life Scieces", "150", "60"),
    );
    userServiceList.add(
      SetAndReturnModels.userService("4", "Sciences", "Geography", "150", "60"),
    );

    //Category 2
    userServiceList.add(
      SetAndReturnModels.userService(
          "5", "Commerce", "Accounting", "200", "60"),
    );
    userServiceList.add(
      SetAndReturnModels.userService(
          "6", "Commerce", "Business Studies", "150", "60"),
    );
    userServiceList.add(
      SetAndReturnModels.userService("7", "Commerce", "Economics", "150", "60"),
    );

    //Category 3
    userServiceList.add(
      SetAndReturnModels.userService("8", "Histories", "History", "150", "60"),
    );
  }

  @override
  void initState() {
    super.initState();
    initScheduleListData();
    initCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      getRequests(),
      null,
      "Services",
      widget.onlineOfflineAppBar,
      floatingActionButton(),
    );
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
      onPressed: () => changeScreen(0, true),
      backgroundColor: Colors.blue,
      child: AppIconsUsed.scheduleAddIcon,
    );
  }

  Widget getRequests() {
    List<Widget> list = [];
    for (int i = 0; i < categoriesList.length; i++) {
      List<Widget> tempServicesList = [];
      for (int j = 0; j < userServiceList.length; j++) {
        if (userServiceList.elementAt(j).getCategory() ==
            categoriesList.elementAt(i)) {
          tempServicesList.add(service(
              j,
              userServiceList.elementAt(j).getServiceDesc(),
              userServiceList.elementAt(j).getPrice()));
        }
      }

      //Dont display any category header that does not have any services
      if (tempServicesList.length > 0) {
        list.add(display(categoriesList.elementAt(i), tempServicesList));
      }
    }
    return new ListView(children: list);
  }

  Widget display(String categorName, List<Widget> tempUserServicesList) {
    return ConfigurableExpansionTile(
      animatedWidgetFollowingHeader: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(
          Icons.expand_more,
          color: black,
          size: 30,
        ),
      ),
      initiallyExpanded: true,
      headerExpanded: category(categorName),
      header: category(categorName),
      headerBackgroundColorStart: AppColors.appBackgroundColor,
      headerBackgroundColorEnd: AppColors.appBackgroundColor,
      expandedBackgroundColor: AppColors.appBackgroundColor,
      children: tempUserServicesList,
    );
  }

  Widget category(String category) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Text(category, style: AppTextStyles.normalBlack(normal, black))
        ],
      ),
    );
  }

  Widget service(int serviceListIndex, String serviceDesc, String price) {
    int index = serviceListIndex;
    return UtilWidget.baseCard(
      null,
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => changeScreen(index, false),
          borderRadius: BorderRadius.circular(25.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListTile(
              title: Text(serviceDesc,
                  style: AppTextStyles.normalBlack(normal, black)),
              subtitle:
                  Text("R$price", style: AppTextStyles.normalGreyishSmall()),
              trailing: AppIconsUsed.iosForwardArrowRounded,
            ),
          ),
        ),
      ),
    );
  }

  void changeScreen(int index, bool addService) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => !addService
            ? ServiceDetails(
                onlineOfflineAppBar: widget.onlineOfflineAppBar,
                userService: userServiceList.elementAt(index),
                categories: categoriesList,
              )
            : ServiceDetails(
                onlineOfflineAppBar: widget.onlineOfflineAppBar,
                categories: categoriesList,
              ),
      ),
    );
  }

  Widget viewText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
              children: [
                TextSpan(text: "You have no services.\n\n"),
                TextSpan(
                    text: "Click here ",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //changeScreen(false);
                      }),
                TextSpan(
                    text: "to add a service OR the round button below.\n\n"),
                TextSpan(
                    text:
                        'Add Service in order for clients to request your services',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
