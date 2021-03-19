import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

import 'package:sticky_headers/sticky_headers.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

import 'package:touch_point_click_service_provider/src/components/dateTimeConvertFunctions.dart';
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
    return UtilWidget.clipRectForApp(
      Container(
        decoration: BoxDecoration(
          color: AppColors.appBackgroundColor, //Color(0xff30384c),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        child: ListView(
          children: [
            Container(
              color: white,
              child: Column(
                children: [
                  Divider(),
                  TableCalendar(
                    calendarController: _calendarController,
                    onDaySelected: (date, events, holidays) {
                      setHeaderState();
                    },
                    initialCalendarFormat: CalendarFormat.week,
                    availableCalendarFormats: const {
                      CalendarFormat.week: 'Week',
                    },
                    initialSelectedDay: _calendarController.selectedDay,
                    formatAnimation: FormatAnimation.slide,
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: true,
                      weekendStyle: AppTextStyles.normalBlackSmall(normal, red),
                      holidayStyle: AppTextStyles.normalBlackSmall(normal, red),
                      weekdayStyle:
                          AppTextStyles.normalBlackSmall(normal, black),
                      outsideStyle:
                          AppTextStyles.normalBlackSmall(normal, blackGrey),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget eventsDisplay() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.appBackgroundColor, //Color(0xff30384c),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          stickyHeader(),
        ],
      ),
    );
  }

  Widget stickyHeader() {
    return StickyHeader(
      header: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: AppColors.appBackgroundColor, //Color(0xff30384c),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        alignment: Alignment.centerLeft,
        child: Text(
          clickedDate,
          style: AppTextStyles.normalLarge(bold, black),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      content: events(),
    );
  }

  String clickedDate = "Today";

  void setHeaderState() {
    setState(() => clickedDate =
        DateTimeConvert.dateFormated(_calendarController.selectedDay));
  }

  Widget text(String address, Color color) {
    return Text(
      address,
      style: AppTextStyles.normalBlack(normal, color),
    );
  }

  Widget events() {
    return Container(
      child: Column(
        children: [
          event("3427 K Section, Botshabelo, 9781", "15:30"),
          event("3427 K Section, Botshabelo, 9781", "15:30"),
          event("3427 K Section, Botshabelo, 9781", "15:30"),
          event("3427 K Section, Botshabelo, 9781", "15:30"),
          event("3427 K Section, Botshabelo, 9781", "15:30"),
          event("3427 K Section, Botshabelo, 9781", "15:30"),
          event("3427 K Section, Botshabelo, 9781", "15:30"),
          event("3427 K Section, Botshabelo, 9781", "15:30"),
          event("3427 K Section, Botshabelo, 9781", "15:30"),
        ],
      ),
    );
  }

  Widget event(String address, String time) {
    return UtilWidget.baseCard(
      null,
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(25.0),
          child: ListTile(
            title: Text(
              address,
              style: AppTextStyles.normalBlack(normal, black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text("Time: $time",
                style: AppTextStyles.normalGreyishSmall(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
            leading: Icon(
              Icons.event,
              color: blue,
              size: 30.0,
            ),
            trailing: AppIconsUsed.iosForwardArrow,
          ),
        ),
      ),
    );
  }
}
