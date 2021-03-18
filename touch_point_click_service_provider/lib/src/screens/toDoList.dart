import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  CalendarController _calendarController;
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final Color white = Colors.white;
  final Color red = Colors.red;
  final Color blue = Colors.blue;
  final Color blackGrey = Colors.black26;
  final Color redGrey = Colors.red[200];
  final Color blueGrey = Colors.blue[300];
  final Color blueAccent = Colors.blueAccent;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Divider(),
        TableCalendar(
          calendarController: _calendarController,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.week: 'Week',
          },
          formatAnimation: FormatAnimation.slide,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: true,
            weekendStyle: AppTextStyles.normalBlackSmall(normal, red),
            holidayStyle: AppTextStyles.normalBlackSmall(normal, red),
            weekdayStyle: AppTextStyles.normalBlackSmall(normal, black),
            outsideStyle: AppTextStyles.normalBlackSmall(normal, blackGrey),
            outsideHolidayStyle:
                AppTextStyles.normalBlackSmall(normal, blackGrey),
            outsideWeekendStyle:
                AppTextStyles.normalBlackSmall(normal, redGrey),
            todayColor: blueGrey,
            selectedColor: blueAccent,
          ),
          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonVisible: false,
            titleTextStyle: AppTextStyles.normalBlack(bold, black),
            rightChevronIcon: AppIconsUsed.iosForwardArrowRounded,
            leftChevronIcon: AppIconsUsed.iosBackwardArrowRounded,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: AppTextStyles.normalBlackSmall(bold, black),
            weekendStyle: AppTextStyles.normalBlackSmall(bold, red),
          ),
        ),
        eventsDisplay(),
      ],
    );
  }

  Widget eventsDisplay() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff30384c),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Stack(children: [
        Column(children: [
          Center(
            child: Container(
                height: 250,
                child: Text("Hello", style: TextStyle(color: white))),
          ),
          Container(
              height: 250,
              child: Text("Hello", style: TextStyle(color: white))),
          Container(
              height: 250,
              child: Text("Hello", style: TextStyle(color: white))),
          Container(
              height: 250,
              child: Text("Hello", style: TextStyle(color: white))),
          Container(
              height: 250,
              child: Text("Hello", style: TextStyle(color: white))),
          Container(
              height: 250,
              child: Text("Hello", style: TextStyle(color: white))),
        ])
      ]),
    );
  }

  static const String pendingAcceptance = "Pending Acceptance";
  static const String pendingAttendance = "Pending Attendance";
  static const String currentlyBusy = "Currently Busy";
  static const String onLunch = "On Lunch";
  static const String loggedIn = "Logged In";
  static const String logout = "Logged Out";

  Widget text(String title, Color color) {
    return Text(
      logout,
      style: AppTextStyles.normalBlack(normal, color),
    );
  }

  Widget textDisplay(String inputText) {
    if (inputText == logout)
      switch (inputText) {
        case logout:
          {
            return text(logout, red);
          }
          break;
        case loggedIn:
          {
            return text(loggedIn, Colors.lightGreenAccent[400]);
          }
          break;
        case onLunch:
          {
            return text(onLunch, blue);
          }
          break;
        case currentlyBusy:
          {
            return text(currentlyBusy, blueAccent);
          }
          break;
        case pendingAttendance:
          {
            return text(pendingAttendance, black);
          }
          break;
        case pendingAcceptance:
          {
            return text(pendingAcceptance, black);
          }
          break;
      }
  }

  Widget event() {
    return UtilWidget.baseCard(
      100,
      ListTile(
        //title: ,//textDisplay(),
        leading: Icon(Icons.blur_circular_outlined, color: white),
      ),
    );
  }
}
