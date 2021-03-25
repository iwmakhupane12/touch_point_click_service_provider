import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

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
      "Request Id: 45632",
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headingText("Service Provider"),
          serviceProvider(),
          headingText("Invoice Details"),
          invoiceDetails(),
          headingText("Bill To"),
          billAddress(),
          headingText("Services"),
          services(),
          amounts(),
        ],
      ),
    );
  }

  final FontWeight bold = FontWeight.bold;
  final FontWeight normal = FontWeight.normal;

  Widget headingText(String text) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 10.0, right: 10.0),
      child: Text(text,
          style: AppTextStyles.normalBlack(normal, Colors.black),
          overflow: TextOverflow.ellipsis,
          maxLines: 1),
    );
  }

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
      null,
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
      null,
      amount(),
    );
  }

  Widget amountText(String text, FontWeight fontWeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
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
        amountText("Paid", normal),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: amountText("Balance Due", bold),
        ),
      ],
    );
  }

  Widget columnPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        amountText(": R550", normal),
        amountText(": R5", normal),
        amountText(": R20", normal),
        amountText(": R0", normal),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: amountText(": R575", bold),
        ),
      ],
    );
  }

  Widget serviceProvider() {
    return UtilWidget.baseCard(
      null,
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                child: Text(
                  "Avocado Holdings",
                  style: AppTextStyles.normalCompanyName(bold, Colors.black),
                ),
              ),
            ],
          ),
          amountText("15423 Grassland, Heidedal, Bloemfontein, 9300", normal),
          amountText("avos@gmail.com", normal),
          amountText("+27 640800828", normal),
        ]),
      ),
    );
  }

  Widget invoiceDetails() {
    return UtilWidget.baseCard(
      null,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            invoiceHeader(),
            invoiceNumbers(),
          ],
        ),
      ),
    );
  }

  Widget invoiceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        amountText("Invoice No", normal),
        amountText("Invoice Date", normal),
        amountText("Due Date", normal),
      ],
    );
  }

  Widget invoiceNumbers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        amountText(": 20210320/01", normal),
        amountText(": 20/03/2021", normal),
        amountText(": 25/03/2021", normal),
      ],
    );
  }

  Widget billAddress() {
    return UtilWidget.baseCard(
      null,
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              amountText("Itumeleng Makhupane", bold),
            ],
          ),
          amountText("3427 K Section, Botshabelo, 9781", normal),
          amountText("iwmakhupane12@gmail.com", normal),
          amountText("+27 629760527", normal),
        ]),
      ),
    );
  }
}
