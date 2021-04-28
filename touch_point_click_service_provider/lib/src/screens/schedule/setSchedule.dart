import 'package:flutter/material.dart';

import 'package:time_range_picker/time_range_picker.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/dateTimeConvertFunctions.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/models/userSchedule.dart';
import 'package:touch_point_click_service_provider/src/screens/schedule/scheduleSettings.dart';

class SetSchedule extends StatefulWidget {
  final UserSchedule userSchedule;
  final bool isDate, newSchedule;

  SetSchedule(this.userSchedule, this.isDate, this.newSchedule);

  @override
  _SetScheduleState createState() => _SetScheduleState();
}

class _SetScheduleState extends State<SetSchedule> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final Color white = Colors.white;
  final DateTime today = DateTime.now();
  bool isDate, newSchedule;
  UserSchedule userSchedule;

  @override
  void initState() {
    super.initState();
    isDate = widget.isDate;
    newSchedule = widget.newSchedule;

    if (widget.userSchedule != null) {
      userSchedule = widget.userSchedule;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      _scaffoldKey,
      ListView(
        children: [
          isDate ? setDate() : setTime(),
          nextBtn(),
        ],
      ),
      null,
      "Schedule Settings",
      null,
      null,
      null,
    );
  }

  //**********Set Time Functions*******************/
  int _radioValue = 1;
  final String _twentyFourFive = "24/5 (Monday - Friday)";
  final String _twentyFourSix = "24/6 (Monday - Saturday)";
  final String _twentyFourSeven = "24/7 (Monday - Sunday)";

  Widget setTime() {
    return UtilWidget.baseCard(
      255,
      Column(
        children: [
          textToCheck("How to Set Time", bold),
          ListTile(
            leading: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: 1,
                groupValue: _radioValue,
                onChanged: (value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
            ),
            title: textToCheck(_byRange, normal),
          ),
          ListTile(
            leading: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: 2,
                groupValue: _radioValue,
                onChanged: (value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
            ),
            title: textToCheck(_twentyFourFive, normal),
          ),
          ListTile(
            leading: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: 3,
                groupValue: _radioValue,
                onChanged: (value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
            ),
            title: textToCheck(_twentyFourSix, normal),
          ),
          ListTile(
            leading: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: 4,
                groupValue: _radioValue,
                onChanged: (value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
            ),
            title: textToCheck(_twentyFourSeven, normal),
          ),
        ],
      ),
    );
  }

  String startTime, endTime;

  void timeRangePicker() async {
    TimeRange result = await showTimeRangePicker(
      context: context,
      start: TimeOfDay(
          hour: DateTimeConvert.initStartEndHoursRangePicker(startTime, null),
          minute:
              DateTimeConvert.initStartEndMinutesRangePicker(startTime, null)),
      end: TimeOfDay(
          hour: DateTimeConvert.initStartEndHoursRangePicker(endTime, "end"),
          minute:
              DateTimeConvert.initStartEndMinutesRangePicker(endTime, "end")),
      use24HourFormat: true,
      disabledTime: TimeRange(
          startTime: TimeOfDay(hour: 23, minute: 55),
          endTime: TimeOfDay(hour: 24, minute: 05)),
      //interval: Duration(hours: 24, minutes: 00),
    );
    if (result != null) {
      startTime = DateTimeConvert.addZeroToTime(
          "${result.startTime.hour}", "${result.startTime.minute}");
      endTime = DateTimeConvert.addZeroToTime(
          "${result.endTime.hour}", "${result.endTime.minute}");

      if (startTime != endTime) {
        setTimeState(startTime, endTime);

        save();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You Cannot Choose Equal Times"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  //**********Set Date Functions*******************/

  final String _byRange = "By Range";
  final String _singular = "Singular";

  Widget setDate() {
    return UtilWidget.baseCard(
      160,
      Column(
        children: [
          textToCheck("How to Set Date", bold),
          ListTile(
            leading: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: 1,
                groupValue: _radioValue,
                onChanged: (value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
            ),
            title: textToCheck(_byRange, normal),
          ),
          ListTile(
            leading: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: 2,
                groupValue: _radioValue,
                onChanged: (value) {
                  setState(() {
                    _radioValue = value;
                  });
                },
              ),
            ),
            title: textToCheck(_singular, normal),
          ),
        ],
      ),
    );
  }

  Widget textToCheck(String text, FontWeight fontWeight) {
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.normalBlack(fontWeight, black),
      ),
    );
  }

  void dateRangePicker() {
    DateTime today = DateTime.now();
    showDateRangePicker(
      context: context,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(today.year, today.month, today.day + 31),
    ).then((DateTimeRange value) {
      if (value != null) {
        DateTimeRange _fromRange = DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        );
        _fromRange = value;
        /*final String range =
            '${DateTimeConvert.dateFormated(_fromRange.start)} - ${DateTimeConvert.dateFormated(_fromRange.end)}';*/
        setDateState(DateTimeConvert.dateFormated(_fromRange.start),
            DateTimeConvert.dateFormated(_fromRange.end));

        save();
      }
    });
  }

  void save() {
    Navigator.pop(context, userSchedule);
  }

  /*void save() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScheduleSettings(
              userSchedule: userSchedule, newSchedule: newSchedule);
        },
      ),
    );
  }*/

  void dateSingularPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(today.year, today.month, today.day + 31),
    ).then(
      (DateTime value) {
        if (value != null) {
          DateTime _fromDate = DateTime.now();
          _fromDate = value;

          setDateState(DateTimeConvert.dateFormated(_fromDate), null);

          save();
        }
      },
    );
  }

  void datePicker() {
    _radioValue == 1 ? dateRangePicker() : dateSingularPicker();
  }

  String buttonText() {
    if (_radioValue > 1) {
      return "Done";
    } else {
      return "Next";
    }
  }

  void setDateState(String dateStart, String dateEnd) {
    if (widget.userSchedule != null) {
      userSchedule.startDate = dateStart;
      userSchedule.endDate = dateEnd;
    } else {
      userSchedule = UserSchedule();
      userSchedule.startDate = dateStart;
      userSchedule.endDate = dateEnd;
    }
  }

  void setTimeState(String timeStart, String timeEnd) {
    setState(() {
      if (widget.userSchedule != null) {
        userSchedule.startTime = timeStart;
        userSchedule.endTime = timeEnd;
      } else {
        userSchedule = UserSchedule();
        userSchedule.startTime = timeStart;
        userSchedule.endTime = timeEnd;
      }
    });
  }

  void timePickerCheck() {
    if (_radioValue == 1) {
      timeRangePicker();
    } else {
      switch (_radioValue) {
        case 2:
          {
            setTimeState(_twentyFourFive, null);
          }
          break;
        case 3:
          {
            setTimeState(_twentyFourSix, null);
          }
          break;
        case 4:
          {
            setTimeState(_twentyFourSeven, null);
          }
          break;
      }

      save();
    }
  }

  Widget nextBtn() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.5,
        child: ElevatedButton(
          style: UtilWidget.buttonStyle,
          child: Text(
            isDate ? "Next" : buttonText(),
            style: AppTextStyles.normalBlack(normal, white),
          ),
          onPressed: () => isDate ? datePicker() : timePickerCheck(),
        ),
      ),
    );
  }
}
