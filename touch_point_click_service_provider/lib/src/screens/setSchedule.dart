import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/dashRequests.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';

class SetSchedule extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  SetSchedule(this.onlineOfflineAppBar);

  @override
  _SetScheduleState createState() => _SetScheduleState();

  dateRangePicker(BuildContext context) {
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
            '${DateFormat.yMMMd().format(_fromRange.start)} - ${DateFormat.yMMMd().format(_fromRange.end)}';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(range),
          ),
        );
      }
    });
  }
}

class _SetScheduleState extends State<SetSchedule> {
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      display(),
      null,
      "Set Schedule",
      widget.onlineOfflineAppBar,
    );
  }

  Widget display() {
    return ListView(
      children: [setDate(), setTime(), nextBtn()],
    );
  }

  int _dateRadioValue = 1;
  int _timeRadioValue = 1;

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
                groupValue: _dateRadioValue,
                onChanged: (value) {
                  setState(() {
                    _dateRadioValue = value;
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
                groupValue: _dateRadioValue,
                onChanged: (value) {
                  setState(() {
                    _dateRadioValue = value;
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

  final String _byRange = "By Range";
  final String _singular = "Singular";

  Widget setTime() {
    return UtilWidget.baseCard(
      160,
      Column(
        children: [
          textToCheck("How to Set Time", bold),
          ListTile(
            leading: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: 1,
                groupValue: _timeRadioValue,
                onChanged: (value) {
                  setState(() {
                    _timeRadioValue = value;
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
                groupValue: _timeRadioValue,
                onChanged: (value) {
                  setState(() {
                    _timeRadioValue = value;
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

  Widget nextBtn() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: UtilWidget.buttonStyle,
          child: Text(
            "Next",
            style: AppTextStyles.normalBlack(normal, white),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
