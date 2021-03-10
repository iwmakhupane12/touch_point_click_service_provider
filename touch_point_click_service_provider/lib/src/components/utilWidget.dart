import 'package:flutter/material.dart';

import 'package:sticky_headers/sticky_headers.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

class UtilWidget {
  static Widget clipRectForApp(Container bodyContainer) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: bodyContainer,
    );
  }

  static void showLoadingDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  message == "" ? "Loading..." : message,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.normalBlack(
                    FontWeight.normal,
                    Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static bool showGoOffline(BuildContext context) {
    bool yes = false;
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Go Offline"),
          content: Text("Are you sure you want to Go Offline?"),
          actions: [
            TextButton(
              child: Text("Yes"),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context, true),
            )
          ],
        );
      },
    ).then(
      (returnVal) {
        if (returnVal == null) {
          yes = false;
        } else {
          yes = returnVal;
        }
      },
    );
    return yes;
  }

  //Text("Note: If you do not have a schedule set, clients will not be able to request your services."),

  //*************************StickyHeader***********************//
  static Widget stickyHeader(String header, Widget content) {
    return StickyHeader(
      header: Container(
        height: 40.0,
        color: AppColors.appBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: Text(
          header,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.normalBlack(FontWeight.normal, Colors.black),
        ),
      ),
      content: content,
    );
  }
}
