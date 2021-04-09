import 'dart:async';

import 'package:flutter/material.dart';

import 'package:country_calling_code_picker/country.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/passwordTextEdit.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/components/validateInput.dart';
import 'package:touch_point_click_service_provider/src/screens/home.dart';
import 'package:touch_point_click_service_provider/src/screens/requests/currentRequest.dart';
import 'package:touch_point_click_service_provider/src/screens/signInOuts/forgotPassword.dart';

class SignIn extends StatefulWidget {
  final Country country;

  SignIn(this.country);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController signInPasswordController, emailController;
  Country _country;

  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;

  final Color black = Colors.black;
  final Color white = Colors.white;

  bool absorb = false;

  @override
  void initState() {
    super.initState();
    signInPasswordController = TextEditingController();
    emailController = TextEditingController();
    _country = widget.country;
  }

  @override
  void dispose() {
    emailController.dispose();
    signInPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorb,
      child: BaseWidget.clipedBase(
        Container(
          //color: Colors.white,
          child: ListView(
            children: [
              headerText("Email Address"),
              Padding(
                padding: padding,
                child: UtilWidget.txtInputText(
                    "info@tpclick.co.za",
                    AppIconsUsed.emailIcon,
                    emailController,
                    TextInputType.emailAddress,
                    true),
              ),
              headerText("Password"),
              Padding(
                padding: padding,
                child: PasswordTextEdit(signInPasswordController),
              ),
              creditialsIncorrect
                  ? ValidateInput.errorText(ValidateInput.incorrectCredintials)
                  : Container(),
              forgotPassword(),
              signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  bool creditialsIncorrect = false;

  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 10.0);

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

  void changeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrentRequest(),
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgotPassword(_country),
                ),
              );
            },
            style: UtilWidget.textButtonStyle,
            child: Text(
              'Forgot your password?',
              style: AppTextStyles.normalBlackSmall(normal, black),
            ),
          ),
        ],
      ),
    );
  }

  void changeToHome() {
    UtilWidget.showLoadingDialog(context, "Signing In...");
    Timer(Duration(seconds: 2), () {
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
      /*setState(() {
        absorb = false;
      });*/
    });
  }

  Widget signInButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              absorb = true;
            });
            changeToHome();
          },
          style: UtilWidget.buttonStyle,
          child: Text(
            "Sign In",
            style: AppTextStyles.normalBlack(normal, white),
          ),
        ),
      ),
    );
  }
}
