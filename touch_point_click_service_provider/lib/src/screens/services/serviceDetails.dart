import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/onlineOfflineAppBar.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/components/validateInput.dart';
import 'package:touch_point_click_service_provider/src/models/userService.dart';
import 'package:touch_point_click_service_provider/src/services/database.dart';

class ServiceDetails extends StatefulWidget {
  final bool newService;
  final UserService userService;
  final List<String> categories;
  final String uid;

  ServiceDetails(
      {@required this.newService,
      this.userService,
      this.categories,
      @required this.uid});

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;
  final Color black = Colors.black;
  final Color white = Colors.white;

  dynamic results;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserService userService;
  List<String> categories = [];
  List<DropdownMenuItem<String>> _dropDownCategoryItems;
  List<Widget> listActions = [];

  String appBarTitle = "Service Details";
  String _radioValue, _uid;

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
      serviceController.text = userService.serviceDesc;
      categoryController.text = userService.category;
      priceController.text =
          UtilWidget.addZeroToMoney(userService.price.toString());
      estTimeController.text = userService.estTime.toString();
      _radioValue = userService.chargeType;
    }
  }

  bool newService = false;

  @override
  void initState() {
    super.initState();
    _uid = widget.uid;
    newService = widget.newService;

    if (!newService) {
      userService = widget.userService;
      categories = widget.categories;
      if (!categories.contains('Our Services')) {
        categories.insert(0, "Our Services");
      }
      if (!userService.deleted) listActions.add(deleteIconBtn());

      initDropDown();
    } else {
      appBarTitle = "Add Service";
      _radioValue = firstValue;
      categories.add("Our Services");
      initDropDown();
    }

    initControllers();
  }

  @override
  void dispose() {
    serviceController.dispose();
    categoryController.dispose();
    priceController.dispose();
    estTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.defaultScreen(
      context,
      _scaffoldKey,
      display(),
      null,
      appBarTitle,
      saveBottomBtn(),
      null,
      listActions,
    );
  }

  Widget deleteIconBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        backgroundColor: AppColors.appBackgroundColor,
        radius: 20,
        child: IconButton(
            icon: AppIconsUsed.deleteIcon,
            onPressed: () {
              deleteBtn();
            }),
      ),
    );
  }

  String determineBtnText() {
    if (newService) {
      return saveService;
    } else if (userService.deleted) {
      return restoreService;
    } else {
      return updateService;
    }
  }

  void determineClickedBtn() {
    if (newService) {
      saveBtn();
    } else if (userService.deleted) {
      restoreBtn();
    } else {
      updateBtn();
    }
  }

  Widget saveBottomBtn() {
    return InkWell(
      onTap: () => determineClickedBtn(),
      child: Container(
          color: Colors.blue,
          height: 50,
          child: Align(
              alignment: Alignment.center,
              child: AppTextStyles.normalText(
                  determineBtnText(), normal, white, 1))),
    );
  }

  Widget display() {
    return AbsorbPointer(
      absorbing: absorb,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: textHeading("Offered Service*"),
          ),
          textFieldView(
              serviceController, TextInputType.text, "e.g. Mathematics"),
          blnService
              ? ValidateInput.errorText(
                  "Offered Service" + ValidateInput.errorTextNull)
              : Container(),
          textHeading("Service Category*"),
          textFieldView(categoryController, TextInputType.text,
              "e.g. Sciences, Histories, Commercial,etc..."),
          Align(
              alignment: Alignment.centerRight,
              child: categoriesDisplayButton()),
          blnCategory
              ? ValidateInput.errorText(
                  "Display Category" + ValidateInput.errorTextNull)
              : Container(),
          textHeading("Price in Rands*"),
          UtilWidget.baseCard(
            null,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textHeading("Price:"),
                textFieldView(
                    priceController, TextInputType.number, "e.g. 150"),
                blnPrice
                    ? ValidateInput.errorText("Price" +
                        ValidateInput.errorTextNull +
                        "\ne.g. 150.99 or 100")
                    : Container(),
                textHeading("How to charge:"),
                chooseChargeType(),
              ],
            ),
          ),
          textHeading("Estimated Time to complete in minutes*"),
          textFieldView(estTimeController, TextInputType.number, "e.g. 60"),
          blnEstTime
              ? ValidateInput.errorText("Estimated Time" +
                  ValidateInput.errorTextNull +
                  "\nDo not use (./,)")
              : Container(),
          //saveButton(),
        ],
      ),
    );
  }

  String offeredService, displayCategory, chargeType;
  double price;
  int estTime;
  bool blnService = false,
      blnCategory = false,
      blnPrice = false,
      blnEstTime = false,
      absorb = false;

  double roundStringToTwoDec(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  bool validateSetVars() {
    bool validate = false;

    if (ValidateInput.validateText(serviceController.text.trim())) {
      offeredService = serviceController.text.trim();
      setState(() => blnService = false);
    } else {
      setState(() => blnService = true);
    }

    if (ValidateInput.validateText(categoryController.text.trim())) {
      displayCategory = categoryController.text.trim();
      setState(() => blnCategory = false);
    } else {
      setState(() => blnCategory = true);
    }

    if (ValidateInput.isDouble(priceController.text.trim())) {
      price = double.parse(priceController.text.trim());
      price = roundStringToTwoDec(price);
      setState(() => blnPrice = false);
    } else {
      setState(() => blnPrice = true);
    }

    if (ValidateInput.isNumeric(estTimeController.text.trim())) {
      estTime = int.parse(estTimeController.text.trim());
      setState(() => blnEstTime = false);
    } else {
      setState(() => blnEstTime = true);
    }

    chargeType = _radioValue;

    if (!blnService && !blnCategory && !blnPrice && !blnEstTime)
      validate = true;

    return validate;
  }

  String firstValue = "For Entire Service";
  String secondValue = "Per Hour";

  Widget chooseChargeType() {
    return Column(
      children: [
        ListTile(
          leading: Transform.scale(
            scale: 1.5,
            child: Radio(
              value: firstValue,
              groupValue: _radioValue,
              onChanged: (value) {
                setState(() {
                  _radioValue = value;
                });
              },
            ),
          ),
          title: textToCheck(firstValue, normal),
        ),
        ListTile(
          leading: Transform.scale(
            scale: 1.5,
            child: Radio(
              value: secondValue,
              groupValue: _radioValue,
              onChanged: (value) {
                setState(() {
                  _radioValue = value;
                });
              },
            ),
          ),
          title: textToCheck(secondValue, normal),
        ),
      ],
    );
  }

  Widget textToCheck(String text, FontWeight fontWeight) {
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.normalBlack(fontWeight, black),
      ),
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
            "Use existing categories",
          ),
          onChanged: (String newValue) => setState(
            () {
              categorySelected = newValue;
              categoryController.text = categorySelected;
            },
          ),
          items: this._dropDownCategoryItems,
        ));
  }

  void initDropDown() {
    _dropDownCategoryItems = categories
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

  void setAbsorbState(bool state) {
    setState(() {
      absorb = state;
    });
  }

  static const String saveService = "Save";
  static const String deleteService = 'Delete';
  static const String restoreService = 'Restore';
  static const String updateService = 'Update';

  void setControllersToNoText() {
    serviceController.text = "";
    categoryController.text = "";
    priceController.text = "";
    estTimeController.text = "";
  }

  void checkAndAddNewCat() {
    if (!categories.contains(categoryController.text.trim())) {
      setState(() {
        categories.add(categoryController.text.trim());
        initDropDown();
      });
    }
  }

  void saveBtn() async {
    results = null;
    if (validateSetVars()) {
      UtilWidget.showLoadingDialog(context, "Saving...");
      setAbsorbState(true);
      dynamic result = await Database(_uid).addServive(
          offeredService, displayCategory, price, chargeType, estTime);
      if (result != null) {
        if (result == "Service Added") {
          Navigator.pop(context);
          UtilWidget.showSnackBar(context, "New Service Added");
          checkAndAddNewCat();
          setControllersToNoText();
          setAbsorbState(false);
        } else {
          print("Unknown Error");
          Navigator.pop(context);
          setAbsorbState(false);
        }
      }
    } else {
      setAbsorbState(false);
    }
  }

  void updateBtn() async {
    results = null;
    if (validateSetVars()) {
      UtilWidget.showLoadingDialog(context, "Updating...");
      setAbsorbState(true);
      dynamic result = await Database(_uid).updateService(userService.docID,
          offeredService, displayCategory, price, chargeType, estTime);
      if (result != null) {
        if (result == "Service Updated") {
          Navigator.pop(context);
          UtilWidget.showSnackBar(context, "Service Updated");
          checkAndAddNewCat();
          setAbsorbState(false);
        } else {
          print("Unknown Error");
          Navigator.pop(context);
        }
      } else {
        Navigator.pop(context);
        setAbsorbState(false);
      }
    }
  }

  void deleteBtn() async {
    results = null;
    UtilWidget.showLoadingDialog(context, "Deleting...");
    setAbsorbState(true);
    dynamic result = await Database(_uid).removeService(userService.docID);
    if (result != null) {
      if (result == "Service Deleted") {
        UtilWidget.showSnackBar(context, "Service Deleted");
        Navigator.pop(context); //Remove loading dialog
        Timer(Duration(milliseconds: 500), () => Navigator.pop(context));
      } else {
        print("Unknown Error");
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
      setAbsorbState(false);
    }
  }

  void restoreBtn() async {
    results = null;
    UtilWidget.showLoadingDialog(context, "Restoring...");
    setAbsorbState(true);
    dynamic result = await Database(_uid).restoreService(userService.docID);
    if (result != null) {
      if (result == "Service Restored") {
        UtilWidget.showSnackBar(context, "Service Restored");
        Navigator.pop(context);
        Timer(Duration(milliseconds: 500), () => Navigator.pop(context));
      } else {
        print("Unknown Error");
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
      setAbsorbState(false);
    }
  }
}
