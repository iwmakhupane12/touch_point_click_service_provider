import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/models/userRequest.dart';

class RequestComp {
  static final FontWeight normal = FontWeight.normal;
  static final FontWeight bold = FontWeight.bold;
  static final Color black = Colors.black;
  static final Color white = Colors.white;

  UserRequest userRequest;
  RequestComp(this.userRequest);

  Widget request() {
    return UtilWidget.baseCard(
      160,
      Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                clientNameText("Itumeleng Makhupane"),
                Divider(),
                addressText("3427 K Section Botshabelo, 9781"),
                dateTimeText("18 Mar 2020", "14:55"),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    requestIdText("45693"),
                    statusButton("Accepted"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget clientNameText(String name) {
    return Text("$name",
        style: AppTextStyles.normalBlack(FontWeight.bold, Colors.black),
        overflow: TextOverflow.ellipsis);
  }

  static Widget addressText(String address) {
    return Text("$address",
        style: AppTextStyles.normalBlack(normal, black),
        overflow: TextOverflow.ellipsis);
  }

  static Widget dateTimeText(String date, String time) {
    return Text("$date @ $time",
        style: AppTextStyles.normalGreyishSmall(),
        overflow: TextOverflow.ellipsis);
  }

  static Widget requestIdText(String id) {
    return Text("Request Id: $id",
        style: AppTextStyles.normalGreyishSmall(),
        overflow: TextOverflow.ellipsis);
  }

  //I will use status to compare the status
  //strings and the incoming status to set the status button
  static const String pendingAcceptance = "Pending Acceptance";
  static const String accepted = "Accepted";
  static const String canceled = "Cancelled";
  static const String current = "Current";

  static final Color pendingAcceptanceColor = Colors.orange;
  static final Color acceptedColor = Colors.teal[800];
  static final Color canceledColor = Colors.red;
  static final Color currentColor = Colors.blue;

  static Color returnStatusColors(String status) {
    switch (status) {
      case pendingAcceptance:
        {
          return pendingAcceptanceColor;
        }
        break;
      case accepted:
        {
          return acceptedColor;
        }
        break;
      case canceled:
        {
          return canceledColor;
        }
        break;
      case current:
        {
          return currentColor;
        }
        break;
      default:
        return Colors.blue;
    }
  }

  static Widget statusButton(String status) {
    return Container(
      decoration: BoxDecoration(
        color: returnStatusColors(status),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            status,
            style: AppTextStyles.normalBlackSmallSmall(normal, white),
          ),
        ),
      ),
    );
  }
}
