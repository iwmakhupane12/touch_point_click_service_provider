import 'package:flutter/material.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/models/userInvoice.dart';

class OfferInvoice extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;
  final UserInvoice invoice;
  OfferInvoice(this.onlineOfflineAppBar, this.invoice);

  @override
  _OfferInvoiceState createState() => _OfferInvoiceState();
}

class _OfferInvoiceState extends State<OfferInvoice> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      screenBody(),
      null,
      "Request",
      widget.onlineOfflineAppBar,
      null,
      null,
    );
  }

  Widget screenBody() {
    return Container(
      child: Center(
        child: Text("Reciept"),
      ),
    );
  }
}
