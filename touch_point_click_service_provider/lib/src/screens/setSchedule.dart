import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:time_range_picker/time_range_picker.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/models/userSchedule.dart';
import 'package:touch_point_click_service_provider/src/screens/scheduleSettings.dart';

class SetSchedule extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;
  final UserSchedule userSchedule;
  final bool isDate;

  SetSchedule(this.onlineOfflineAppBar, this.userSchedule, this.isDate);

  @override
  _SetScheduleState createState() => _SetScheduleState();
}

class _SetScheduleState extends State<SetSchedule> {
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final Color white = Colors.white;
  final DateTime today = DateTime.now();
  bool isDate;
  UserSchedule userSchedule;

  @override
  void initState() {
    super.initState();
    isDate = widget.isDate;
    if (widget.userSchedule != null) {
      userSchedule = widget.userSchedule;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      Column(
        children: [isDate ? setDate() : setTime(), nextBtn()],
      ),
      null,
      "Schedule Settings",
      widget.onlineOfflineAppBar,
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

  List<String> splitTime(String time) {
    return time.split(':').toList();
  }

  int startEndHoursRangePicker(String time, String end) {
    //For start time
    if (time != null && end == null) {
      return int.parse(splitTime(time).first);
    } else if (time == null && end == null) {
      return TimeOfDay.now().hour;
    } else {
      int endHour = TimeOfDay.now().hour + 3;
      if (endHour >= 24) {
        endHour = 0 + (endHour - 24); //Setting time to 24 hours
      }
      return endHour; //No time set and its for end time
    }
  }

  int startEndMinutesRangePicker(String time, String end) {
    //For end time
    return time != null && end == null
        ? int.parse(splitTime(time).last)
        : TimeOfDay.now().minute;
  }

  String addZeroToTime(String hours, String minutes) {
    if (hours.length <= 1) {
      hours = "0$hours";
    }

    if (minutes.length <= 1) {
      minutes = "0$minutes";
    }

    return "$hours:$minutes";
  }

  void timeRangePicker() async {
    TimeRange result = await showTimeRangePicker(
      context: context,
      start: TimeOfDay(
          hour: startEndHoursRangePicker(startTime, null),
          minute: startEndMinutesRangePicker(startTime, null)),
      end: TimeOfDay(
          hour: startEndHoursRangePicker(endTime, "end"),
          minute: startEndMinutesRangePicker(endTime, "end")),
      use24HourFormat: true,
      //interval: Duration(hours: 24, minutes: 00),
    );
    if (result != null) {
      startTime = addZeroToTime(
          "${result.startTime.hour}", "${result.startTime.minute}");
      endTime =
          addZeroToTime("${result.endTime.hour}", "${result.endTime.minute}");

      setState(() {
        if (widget.userSchedule != null) {
          userSchedule.setStartTime(startTime);
          userSchedule.setEndTime(endTime);
        } else {
          userSchedule = UserSchedule();
          userSchedule.setStartTime(startTime);
          userSchedule.setEndTime(endTime);
        }
      });

      save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$startTime - $endTime"),
        ),
      );
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
        final String range =
            '${dateFormated(_fromRange.start)} - ${dateFormated(_fromRange.end)}';

        if (widget.userSchedule != null) {
          userSchedule.setStartDate(dateFormated(_fromRange.start));
          userSchedule.setEndDate(dateFormated(_fromRange.end));
        } else {
          userSchedule = UserSchedule();
          userSchedule.setStartDate(dateFormated(_fromRange.start));
          userSchedule.setEndDate(dateFormated(_fromRange.end));
        }

        save();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(range),
          ),
        );
      }
    });
  }

  String dateFormated(DateTime fromRange) {
    return '${DateFormat.d().format(fromRange)} ${DateFormat.MMM().format(fromRange)} ${DateFormat.y().format(fromRange)}';
  }

  void save() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ScheduleSettings(
              onlineOfflineAppBar: widget.onlineOfflineAppBar,
              userSchedule: userSchedule);
        },
      ),
    );
  }

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

          if (widget.userSchedule != null) {
            userSchedule.setStartDate(dateFormated(_fromDate));
            userSchedule.setEndDate(null);
          } else {
            userSchedule = UserSchedule();
            userSchedule.setStartDate(dateFormated(_fromDate));
            userSchedule.setEndDate(null);
          }

          save();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(dateFormated(_fromDate)),
            ),
          );
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

  void timePickerCheck() {
    if (_radioValue == 1) {
      timeRangePicker();
    } else {
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
