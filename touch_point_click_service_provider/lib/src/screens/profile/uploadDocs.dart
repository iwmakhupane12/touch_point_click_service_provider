import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';

class UploadDocs extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  UploadDocs(this.onlineOfflineAppBar);

  @override
  _UploadDocsState createState() => _UploadDocsState();
}

class _UploadDocsState extends State<UploadDocs> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      Container(
        child: Center(child: Text("Upload Documents")),
      ),
      null,
      "Upload Documents",
      widget.onlineOfflineAppBar,
      null,
      null,
    );
  }
}
