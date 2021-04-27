import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/components/appBarTabs.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/models/userService.dart';
import 'package:touch_point_click_service_provider/src/screens/home.dart';
import 'package:touch_point_click_service_provider/src/screens/services/serviceDetails.dart';
import 'package:touch_point_click_service_provider/src/services/database.dart';

class Services extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;
  final dynamic results;
  final String success;

  Services(this.onlineOfflineAppBar, this.results, this.success);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  String _uid;

  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;

  final Color black = Colors.black;
  final Color white = Colors.white;
  final Color blue = Colors.blue;

  List<UserService> userServiceList = [];
  List<bool> categoryBoolExpandedList = [];
  List<String> categoriesList = [];

  void initCategories() {
    for (int i = 0; i < userServiceList.length; i++) {
      //Checks if the category is already in the list and if not, add it
      if (!categoriesList.contains(userServiceList.elementAt(i).category)) {
        categoriesList.add(userServiceList.elementAt(i).category);
        categoryBoolExpandedList.add(false); //Initialising
      }
    }
  }

  bool gettingServices = true;

  dynamic results;
  String success;

  void initServices() {
    if (results != null) {
      if (success == "Success") {
        userServiceList = results;
      } else if (results == "No Services") {
        print("No Services");
      } else {
        print("Unknown Error");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _uid = FirebaseAuth.instance.currentUser.uid; //Getting user Id
    results = widget.results;
    success = widget.success;
    initServices();
    initCategories();
    setActiveServices();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: BaseWidget.defaultScreen(
          context,
          screenBody(),
          AppBarTabs.twoAppBarBottomTabs("Active", "Deleted"),
          "Services",
          widget.onlineOfflineAppBar,
          floatingActionButton(),
          null,
        ));
  }

  FutureOr _onGoBack(dynamic value) async {
    //UtilWidget.showLoadingDialog(context, "Getting Services");
    Database database = Database(_uid);
    dynamic backResults = await database.fetchServices();
    Timer(Duration(milliseconds: 500), () {
      if (backResults != null) {
        if (backResults != "Unknown Error") {
          setState(() {
            results = backResults;
            success = database.queryResults;
            activeList = [];
            deletedList = [];
            userServiceList = [];
            categoriesList = [];
            initServices();
            initCategories();
            setActiveServices();
          });
        } else {
          //Show snackbar of an error loading services, check internet connection
        }
      }
    });
    //Navigator.pop(context); //Remove loading dialog
  }

  Widget screenBody() {
    return TabBarView(children: [
      Container(
        child: activeServices(),
      ),
      Container(
        child: deletedServices(),
      )
    ]);
  }

  Widget activeServices() {
    return activeList.length <= 0 ? viewText() : ListView(children: activeList);
  }

  Widget deletedServices() {
    return deletedList.length <= 0
        ? noDeletedServices()
        : ListView(children: deletedList);
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
      onPressed: () => changeScreen(0, true),
      backgroundColor: Colors.blue,
      child: AppIconsUsed.scheduleAddIcon,
    );
  }

  List<Widget> activeList = [], deletedList = [];

  void setActiveServices() {
    for (int i = 0; i < categoriesList.length; i++) {
      List<Widget> tempServicesList = [], tempDeletedService = [];
      for (int j = 0; j < userServiceList.length; j++) {
        if (userServiceList.elementAt(j).category ==
            categoriesList.elementAt(i)) {
          if (!userServiceList.elementAt(j).deleted) {
            //Active
            tempServicesList.add(
              service(
                j,
                userServiceList.elementAt(j).serviceDesc,
                userServiceList.elementAt(j).price,
                userServiceList.elementAt(j).chargeType,
              ),
            );
          } else {
            //Deleted
            tempDeletedService.add(
              service(
                j,
                userServiceList.elementAt(j).serviceDesc,
                userServiceList.elementAt(j).price,
                userServiceList.elementAt(j).chargeType,
              ),
            );
          }
        }
      }

      //Dont display any category header that does not have any services
      if (tempServicesList.length > 0) {
        activeList.add(display(categoriesList.elementAt(i), tempServicesList));
      }

      if (tempDeletedService.length > 0) {
        deletedList
            .add(display(categoriesList.elementAt(i), tempDeletedService));
      }
    }
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

  Widget service(int serviceListIndex, String serviceDesc, double price,
      String chargeType) {
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
              subtitle: Text(
                  "R${UtilWidget.addZeroToMoney(price.toString())} \u00B7 $chargeType",
                  style: AppTextStyles.normalGreyishSmall()),
              trailing: AppIconsUsed.iosForwardArrowRounded,
            ),
          ),
        ),
      ),
    );
  }

  void changeScreen(int index, bool addService) {
    UserService sendUserService = userServiceList.elementAt(index);
    List<String> sendCategory = categoriesList;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => !addService
            ? ServiceDetails(
                onlineOfflineAppBar: widget.onlineOfflineAppBar,
                userService: sendUserService,
                categories: sendCategory,
                uid: _uid,
                newService: false,
              )
            : ServiceDetails(
                onlineOfflineAppBar: widget.onlineOfflineAppBar,
                categories: sendCategory,
                uid: _uid,
                newService: true,
              ),
      ),
    ).then(_onGoBack);
  }

  Widget viewText() {
    return ListView(children: [
      Padding(
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
                        ..onTap = () async {
                          //changeScreen(0, true);
                          dynamic time = await UtilWidget.internetDateTime();
                          if (time != null) {
                            print(UtilWidget.internetDateTime());
                          }
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
      ),
    ]);
  }

  Widget noDeletedServices() {
    return ListView(children: [
      Padding(
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
                  TextSpan(text: "You have no deleted services."),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
