import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:touch_point_click_service_provider/src/services/userAuth.dart';

class SignIn extends StatefulWidget {
  final Country country;

  SignIn(this.country);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController signInPasswordController, emailController;
  Country _country;

  UserAuth userAuth = UserAuth();

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
              emptyTexts
                  ? ValidateInput.errorText("Enter your Email and Password")
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  bool creditialsIncorrect = false, emptyTexts = false;

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
    Timer(Duration(seconds: 1), () {
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

  String password, email;

  void initVars() {
    if (signInPasswordController.text == "" || emailController.text == "") {
      setState(() => emptyTexts = true);
    } else {
      setState(() => emptyTexts = false);
      password = signInPasswordController.text.trim();
      email = emailController.text.trim();
    }
  }

  void setAbsorb(bool state) {
    setState(() => absorb = state);
  }

  void setIncorrectCreds(bool state) {
    setState(() => creditialsIncorrect = state);
  }

  Widget signInButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            initVars();
            if (!emptyTexts) {
              setAbsorb(true);
              UtilWidget.showLoadingDialog(context, "Signing In...");
              dynamic result =
                  await userAuth.signInEmailPassword(email, password);
              if (result != null) {
                if (result == 'user-not-found') {
                  print('The user email does not exist.');
                  Navigator.pop(context);
                  setIncorrectCreds(false);
                  setAbsorb(false);
                } else if (result == 'wrong-password') {
                  print('Incorrect password.');
                  Navigator.pop(context);
                  setIncorrectCreds(false);
                  setAbsorb(false);
                } else if (result == "Success") {
                  changeToHome();
                } else {
                  print('Unknown Error');
                  Navigator.pop(context);
                  setIncorrectCreds(true);
                  setAbsorb(false);
                }
              }
            }
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
