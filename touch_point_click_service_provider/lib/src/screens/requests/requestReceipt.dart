import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

class RequestReceipt extends StatefulWidget {
  @override
  _RequestReceiptState createState() => _RequestReceiptState();
}

class _RequestReceiptState extends State<RequestReceipt> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [stickyHeader()]);
  }

  Widget stickyHeader() {
    return UtilWidget.stickyHeader(
      "3427 K Section Botshabelo, 9781",
      Column(
        children: [
          services(),
          amounts(),
          resendButton(),
        ],
      ),
    );
  }

  final FontWeight bold = FontWeight.bold;
  final FontWeight normal = FontWeight.normal;

  Widget text(String text, FontWeight fontWeight) {
    return Text(text,
        style: AppTextStyles.normalBlack(fontWeight, Colors.black),
        overflow: TextOverflow.ellipsis,
        maxLines: 2);
  }

  Widget service(String qty, String service, String price) {
    return ListTile(
      leading: text(qty, normal),
      title: text(service, normal),
      trailing: text("R$price", normal),
    );
  }

  Widget headerDisplay() {
    return ListTile(
      leading: text("Qty", bold),
      title: text("Service", bold),
      trailing: text("Price", bold),
    );
  }

  Widget services() {
    return UtilWidget.baseCard(
      200,
      Column(
        children: [
          headerDisplay(),
          Divider(),
          service("2", "Mathematics", "400"),
          service("1", "Technology", "150"),
        ],
      ),
    );
  }

  Widget amounts() {
    return UtilWidget.baseCard(
      153,
      amount(),
    );
  }

  Widget amountText(String text, FontWeight fontWeight) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 8.0, left: 8.0),
      child: Text(
        text,
        style: AppTextStyles.normalBlack(fontWeight, Colors.black),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [columnHeader(), columnPrice()],
      ),
    );
  }

  Widget columnHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        amountText("Sub Total", normal),
        amountText("Service Fee", normal),
        amountText("Distance Fee", normal),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: amountText("Total", bold),
        ),
      ],
    );
  }

  Widget columnPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        amountText("R550", normal),
        amountText("R5", normal),
        amountText("R20", normal),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: amountText("R575", bold),
        ),
      ],
    );
  }

  Widget resendButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {},
          style: UtilWidget.buttonStyle,
          child: Text(
            "Resend Receipt",
            style: AppTextStyles.normalBlack(normal, Colors.white),
          ),
        ),
      ),
    );
  }
}
