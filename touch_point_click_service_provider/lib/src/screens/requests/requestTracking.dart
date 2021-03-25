import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/screens/requests/invoiceUpdate.dart';

class RequestTracking extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;

  RequestTracking(this.onlineOfflineAppBar);

  @override
  _RequestTrackingState createState() => _RequestTrackingState();
}

class _RequestTrackingState extends State<RequestTracking> {
  final FontWeight normal = FontWeight.normal;
  final Color black = Colors.black;
  final Color white = Colors.white;

  List<Widget> timeLineInfo = [];
  List<TimeLineHeader> timeLineList = [];

  @override
  void initState() {
    super.initState();
    initTimeLineClassesList();
    initTimeLine();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [stickyHeader()]);
  }

  Widget stickyHeader() {
    return UtilWidget.stickyHeader(
      "Request Id: 45632",
      Column(children: timeLineInfo),
    );
  }

  void initTimeLineClassesList() {
    timeLineList.add(new TimeLineHeader(
        "0", "Request Accepted", "22 Mar 2020", "16:47", ""));
    timeLineList.add(new TimeLineHeader(
        "1", "Going To Client's Location?", "24 Mar 2020", "12:00", "Yes"));
    timeLineList.add(new TimeLineHeader(
        "2", "Arrived At Location?", "24 Mar 2020", "12:22", "Yes"));
    timeLineList.add(new TimeLineHeader(
        "3", "Started Working?", "24 Mar 2020", "12:30", "Yes"));
    timeLineList
        .add(new TimeLineHeader("4", "Complete?", "24 Mar 2020", "13:30", ""));
  }

  void initTimeLine() {
    for (int i = 0; i < 5; i++) {
      timeLineInfo.add(timeLineWidget(i));
    }
  }

  Widget popTextButton(String clicked) {
    return UtilWidget.baseCard(
      50,
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pop(context, clicked),
          borderRadius: BorderRadius.circular(25.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              clicked,
              style: AppTextStyles.normalBlack(normal, black),
            ),
          ),
        ),
      ),
    );
  }

  void clientPaidBy() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Text("Did the client pay or they asked for an invoice?"),
        children: [
          popTextButton("Payed"),
          popTextButton("Invoice"),
        ],
      ),
    ).then(
      (value) {
        if (value != null) {
          changeScreen();
        }
      },
    );
  }

  void changeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            InvoiceUpdate(onlineOfflineAppBar: widget.onlineOfflineAppBar),
      ),
    );
  }

  Widget timeLineWidget(int index) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              index > 0
                  ? Container(
                      width: 2,
                      height: 50,
                      color: Colors.grey,
                    )
                  : new Container(height: 50),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50)),
                child: AppIconsUsed.timeLineCheck,
              ),
              index < 4
                  ? Container(
                      width: 2,
                      height: 50,
                      color: Colors.grey,
                    )
                  : new Container(height: 50),
            ],
          ),
          Expanded(
            child: Container(
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
              height: null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(timeLineList.elementAt(index).getTitle(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTextStyles.normalBlack(normal, black)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${timeLineList.elementAt(index).getDate()} @ ${timeLineList.elementAt(index).getTime()}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyles.normalGreyishSmall()),
                        timeLineList.elementAt(index).getID() != "0"
                            ? ElevatedButton(
                                onPressed: () {
                                  timeLineList.elementAt(index).getID() == "4"
                                      ? clientPaidBy()
                                      : null;
                                },
                                style: UtilWidget.buttonStyle,
                                child: Text(
                                  "Yes",
                                  style: AppTextStyles.normalBlackSmall(
                                      normal, white),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TimeLineHeader {
  String _id, _title, _date, _time, _btnText;

  TimeLineHeader(this._id, this._title, this._date, this._time, this._btnText);

  String getID() => this._id;
  String getTitle() => this._title;
  String getDate() => this._date;
  String getTime() => this._time;
  String getBtnText() => this._btnText;
}
