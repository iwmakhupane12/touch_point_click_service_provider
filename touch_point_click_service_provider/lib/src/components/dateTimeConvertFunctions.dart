import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeConvert {
  ///////////////////Time Functions///////////////////
  //Splits time to list
  static List<String> splitTime(String time) {
    return time.split(':').toList();
  }

  //Setting time for time range for start and end in hours
  static int initStartEndHoursRangePicker(String time, String end) {
    //For start time
    if (time != null && end == null) {
      return int.parse(splitTime(time).first);
    } else if (time == null && end == null) {
      return TimeOfDay.now().hour;
    } else {
      //For end Time
      int endHour = TimeOfDay.now().hour + 3;
      if (endHour >= 24) {
        endHour = 0 + (endHour - 24); //Setting time to 24 hours
      }
      return endHour; //No time set and its for end time
    }
  }

  static int initStartEndMinutesRangePicker(String time, String end) {
    //For end time
    return time != null && end == null
        ? int.parse(splitTime(time).last)
        : TimeOfDay.now().minute;
  }

  static String addZeroToTime(String hours, String minutes) {
    if (hours.length <= 1) {
      hours = "0$hours";
    }

    if (minutes.length <= 1) {
      minutes = "0$minutes";
    }

    return "$hours:$minutes";
  }

  ///////////////////Date Functions///////////////////
  static String dateFormated(DateTime fromRange) {
    return '${DateFormat.d().format(fromRange)} ${DateFormat.MMM().format(fromRange)} ${DateFormat.y().format(fromRange)}';
  }
}
