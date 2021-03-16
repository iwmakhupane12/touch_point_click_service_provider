import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  CalendarController _calendarController;

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
          calendarController: _calendarController, //onDaySelected: ,
        ),
        eventsDisplay(),
      ],
    );
  }

  Widget eventsDisplay() {
    return BaseWidget.clipedBase(
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Center(
              child: Container(height: 250, child: Text("Hello")),
            ),
            Container(height: 250, child: Text("Hello")),
            Container(height: 250, child: Text("Hello")),
            Container(height: 250, child: Text("Hello")),
            Container(
                height: 250, child: Text("Hello")), //Doesnt show  the last 2
            Container(height: 250, child: Text("Hello")),
          ],
        ),
      ),
    );
  }
}
