import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

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

  static Future internetDateTime() async {
    dynamic startDate = await NTP.now();
    return startDate;
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        content: Text(
          "$message",
          style: AppTextStyles.normalBlack(FontWeight.normal, Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  static String addZeroToMoney(String money) {
    List<String> price = money.split(".");
    if (price.elementAt(1).length == 1) {
      return money + "0";
    }
    return money;
  }

  static Widget baseCard(double height, Widget displayWidget) {
    return Container(
      height: height,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26, //Color(0x802196F3),
            )
          ],
          borderRadius: BorderRadius.circular(25)),
      child: displayWidget,
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

  static ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );

  static ButtonStyle textButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );

  static Widget txtInputText(
      String txtHint,
      Icon txtIcons,
      TextEditingController controller,
      TextInputType textInputType,
      bool enabled) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: textInputType,
        style: TextStyle(fontSize: 20, height: 1.0),
        decoration: UtilWidget.txtInputDecor(txtHint, txtIcons, null),
      ),
    );
  }

  static InputDecoration txtInputDecor(
      String txtHintText, Icon txtPrefixIcon, IconButton txtSuffixIconButton) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: txtHintText,
      hintStyle: TextStyle(color: Colors.grey),
      suffixIcon: txtSuffixIconButton,
      prefixIcon: txtPrefixIcon,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
  }
}
