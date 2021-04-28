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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      _scaffoldKey,
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
