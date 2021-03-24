import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/phoneNumEditText.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';

class ForgotPassword extends StatefulWidget {
  final Country country;

  ForgotPassword(this.country);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;

  final Color black = Colors.black;
  final Color white = Colors.white;

  Country _country;

  TextEditingController phoneNumController, emailController;

  PhoneNumEditText phoneNumEditText;

  @override
  void initState() {
    super.initState();
    phoneNumController = TextEditingController();
    emailController = TextEditingController();
    _country = widget.country;
    phoneNumEditText = PhoneNumEditText(phoneNumController, _country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Forgot Password",
          style: AppTextStyles.normalBlack(normal, black),
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 0.0,
      ),
      body: BaseWidget.clipedBase(
        ListView(
          children: [
            headerNote(
                "Use either your Email Address or Phone Number to reset password."),
            SizedBox(height: 20),
            headerText("Email Address"),
            Padding(
              padding: padding,
              child: UtilWidget.txtInputText(
                "info@tpclick.co.za",
                AppIconsUsed.emailIcon,
                emailController,
                TextInputType.emailAddress,
              ),
            ),
            headerText("Phone Number"),
            Padding(
              padding: padding,
              child: phoneNumEditText,
            ),
            requestOTPButton(),
          ],
        ),
      ),
    );
  }

  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 10.0);

  Widget headerNote(String text) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 15.0, left: 20.0, right: 20.0, bottom: 5.0),
      child: RichText(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        text: TextSpan(
          text: text,
          style: AppTextStyles.normalBlack(normal, black),
        ),
      ),
    );
  }

  Widget headerText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 15.0, left: 20.0, right: 20.0, bottom: 5.0),
      child: Text(
        text,
        style: AppTextStyles.normalBlack(normal, black),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget requestOTPButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            //Home();
          },
          style: UtilWidget.buttonStyle,
          child: Text(
            "Request One-Time Pin",
            style: AppTextStyles.normalBlack(normal, white),
          ),
        ),
      ),
    );
  }
}
