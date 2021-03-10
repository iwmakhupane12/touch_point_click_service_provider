import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

class BaseWidget {
  static Widget clipedBase(Widget display) {
    return UtilWidget.clipRectForApp(
      Container(
        color: AppColors.appBackgroundColor,
        child: display,
      ),
    );
  }
}
