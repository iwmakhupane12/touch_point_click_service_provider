import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/dashRequests.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

class PendingAccept extends StatefulWidget {
  final String requestNumber, requestDate, requestTime, requestAddress;

  PendingAccept(this.requestNumber, this.requestAddress, this.requestDate,
      this.requestTime);

  @override
  _PendingAcceptState createState() => _PendingAcceptState();
}

class _PendingAcceptState extends State<PendingAccept> {
  FontWeight bold = FontWeight.bold;
  FontWeight normal = FontWeight.normal;
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return requestDisplay();
  }

  Widget requestDisplay() {
    return Container(
      height: 145,
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
      child: InkWell(
        onTap: () {},
        radius: 25.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.requestAddress,
                      style: AppTextStyles.normalBlack(normal, color),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Divider(),
                    Text(
                      widget.requestDate + " @ " + widget.requestTime,
                      style: AppTextStyles.normalGreyishSmall(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Request Id: " + widget.requestNumber,
                            style: AppTextStyles.normalGreyishSmall(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trackingStatusUpdate()
                        ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget trackingStatusUpdate() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      child: Text("View"),
      onPressed: () {},
    );
    /*Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.blue),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.updateTrackingStatus,
            style: AppTextStyles.normalBlackSmall(normal, Colors.white),
          ),
        ),
      ),
    );*/
  }
}
