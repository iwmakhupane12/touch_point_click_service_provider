import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

class RequestDetails extends StatefulWidget {
  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  final FontWeight bold = FontWeight.bold;
  final FontWeight normal = FontWeight.normal;

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
          headingText("Status"),
          status(),
          headingText("Client"),
          client(),
          headingText("Request"),
          constraints(),
          headingText("Services"),
          services(),
          headingText("Amounts"),
          amounts(),
        ],
      ),
    );
  }

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

  Widget rating(String companyRating, String companyRatedNumber) {
    return Container(
      child: Row(
        children: <Widget>[
          AppIconsUsed.greyRatingStar,
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
                //"4.3 (200+) \u00B7 10km away"
                companyRating + " (" + companyRatedNumber + ")",
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.normalBlackSmallSmall(
                    FontWeight.normal, Colors.grey[600])),
          ),
        ],
      ),
    );
  }

  Widget status() {
    return UtilWidget.baseCard(
      null,
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Cancelled By Client",
              style: AppTextStyles.normalBlack(normal, black),
            ),
          ],
        ),
      ),
    );
  }

  Widget clientText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        text,
        style: AppTextStyles.normalBlack(normal, black),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget client() {
    return UtilWidget.baseCard(
      null,
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lerato Makhupane",
              style: AppTextStyles.normalBlack(bold, black),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            clientText("lerato@gmail.com"),
            clientText("+27 629760527"),
            rating("4.5", "300"),
          ],
        ),
      ),
    );
  }

  Widget constraints() {
    return UtilWidget.baseCard(
      null,
      Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              onTap: () {},
              child: constraintsTile(AppIconsUsed.locationPinLarge,
                  "Client Address", "3427 K Section, Botshabelo, 9781", true),
            ),
          ),
          constraintsTile(AppIconsUsed.calendarIcon, "Date & Time",
              "21 Mar 2021 @ 14:00", false),
          constraintsTile(
              AppIconsUsed.arrivalNote, "Arrival Note", "No note", false),
          constraintsTile(
              AppIconsUsed.cardPayment, "Payment Method", "Cash", false)
        ],
      ),
    );
  }

  final Color black = Colors.black;

  Widget constraintsTile(
      Icon trailingIcon, String title, String subTitle, bool viewArrow) {
    return ListTile(
      leading: trailingIcon,
      title: Text(title,
          style: AppTextStyles.normalBlackSmall(normal, black),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
      subtitle: Text(subTitle,
          style: AppTextStyles.normalGreyishSmall(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis),
      trailing: viewArrow ? AppIconsUsed.iosForwardArrowRounded : null,
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
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [columnHeader(), columnPrice()],
        ),
      ),
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
        amountText(": R550", normal),
        amountText(": R5", normal),
        amountText(": R20", normal),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: amountText(": R575", bold),
        ),
      ],
    );
  }
}
