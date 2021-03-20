import 'package:flutter/material.dart';

class RequestInvoice extends StatefulWidget {
  @override
  _RequestInvoiceState createState() => _RequestInvoiceState();
}

class _RequestInvoiceState extends State<RequestInvoice> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [stickyHeader()]);
  }

  Widget stickyHeader() {
    return UtilWidget.stickyHeader(
      "3427 K Section Botshabelo, 9781",
      Column(
        children: [
          serviceProvider(),
          invoiceDetails(),
          billAddress(),
          services(),
          amounts(),
        ],
      ),
    );
  }
}
