import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/models/userService.dart';

class ServiceDetails extends StatefulWidget {
  final OnlineOfflineAppBar onlineOfflineAppBar;
  final UserService userService;
  final List<String> categories;

  ServiceDetails(
      {@required this.onlineOfflineAppBar, this.userService, this.categories});

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  UserService userService;
  List<String> categories;
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  String appBarTitle = "Service Details";

  TextEditingController serviceController,
      categoryController,
      priceController,
      estTimeController;

  void initControllers() {
    serviceController = TextEditingController();
    categoryController = TextEditingController();
    priceController = TextEditingController();
    estTimeController = TextEditingController();

    if (userService != null) {
      serviceController.text = userService.getServiceDesc();
      categoryController.text = userService.getCategory();
      priceController.text = userService.getPrice();
      estTimeController.text = userService.getEstTime();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.userService != null) {
      userService = widget.userService;
    } else {
      appBarTitle = "Add Service";
    }

    if (widget.categories != null) {
      categories = widget.categories;
      initDropDown();
    }

    initControllers();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      display(),
      null,
      appBarTitle,
      widget.onlineOfflineAppBar,
      null,
      null,
    );
  }

  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final Color white = Colors.white;

  Widget display() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: textHeading("Offered Service:"),
        ),
        textFieldView(
            serviceController, TextInputType.text, "e.g. Mathematics"),
        textHeading("Display Category:"),
        textFieldView(categoryController, TextInputType.text,
            "e.g. Sciences, Histories, Commercial,etc..."),
        Align(
            alignment: Alignment.centerRight, child: categoriesDisplayButton()),
        textHeading("Price in Rands:"),
        textFieldView(priceController,
            TextInputType.numberWithOptions(decimal: true), "e.g. 150"),
        textHeading("Estimated Time to complete in minutes:"),
        textFieldView(estTimeController,
            TextInputType.numberWithOptions(decimal: false), "e.g. 60"),
        saveButton(),
      ],
    );
  }

  Widget textHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, left: 12.0, top: 10.0),
      child: Text(text,
          style: AppTextStyles.normalBlack(normal, black),
          overflow: TextOverflow.ellipsis),
    );
  }

  String categorySelected;

  Widget categoriesDisplayButton() {
    return Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: DropdownButton<String>(
          value: categorySelected,
          hint: Text(
            "Use your existing categories",
          ),
          onChanged: (String newValue) => setState(
            () {
              categorySelected = newValue;
              categoryController.text = categorySelected;
            },
          ),
          items: this._dropDownMenuItems,
        ));
  }

  void initDropDown() {
    _dropDownMenuItems = categories
        .map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
        .toList();
  }

  Widget textFieldView(TextEditingController controller,
      TextInputType keyboardType, String hint) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Card(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: null,
          style: TextStyle(fontSize: 20, height: 1.0),
          decoration: UtilWidget.txtInputDecor(hint, null, null),
        ),
      ),
    );
  }

  Widget saveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {},
          style: UtilWidget.buttonStyle,
          child: Text(
            "Save",
            style: AppTextStyles.normalBlack(normal, white),
          ),
        ),
      ),
    );
  }
}
