import 'dart:async';

import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:country_calling_code_picker/country.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/passwordTextEdit.dart';
import 'package:touch_point_click_service_provider/src/components/phoneNumEditText.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/components/validateInput.dart';
import 'package:touch_point_click_service_provider/src/screens/home.dart';

class SignUp extends StatefulWidget {
  final Country country;

  SignUp(this.country);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _providerNameController,
      _phoneNumController,
      _altPhoneNumController,
      _emailController,
      _passwordController,
      _confirmPasswordController;

  Country _country;

  PhoneNumEditText phoneNumEditText, altPhoneNumEditText;

  final FontWeight normal = FontWeight.normal;
  final FontWeight bold = FontWeight.bold;

  final Color black = Colors.black;
  final Color white = Colors.white;

  bool absorb = false;

  @override
  void initState() {
    super.initState();
    initControllers();
    _country = widget.country;

    phoneNumEditText = PhoneNumEditText(_phoneNumController, _country);
    altPhoneNumEditText = PhoneNumEditText(_altPhoneNumController, _country);
  }

  void initControllers() {
    _providerNameController = TextEditingController();
    _phoneNumController = TextEditingController();
    _altPhoneNumController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _providerNameController.dispose();
    _phoneNumController.dispose();
    _altPhoneNumController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorb,
      child: BaseWidget.clipedBase(
        ListView(
          children: [
            headerText("Service Provider Name*"),
            Padding(
              padding: padding,
              child: UtilWidget.txtInputText(
                  "Touchpoint Click Pty(Ltd)",
                  AppIconsUsed.personIcon,
                  _providerNameController,
                  TextInputType.text,
                  true),
            ),
            blnName
                ? Container()
                : ValidateInput.errorText(
                    "Service Provider's Name ${ValidateInput.errorTextNull}"),
            headerText("Phone Number*"),
            Padding(
              padding: padding,
              child: phoneNumEditText,
            ),
            blnPhone
                ? Container()
                : ValidateInput.errorText(
                    "Phone Number ${ValidateInput.errorTextNull}"),
            headerText("Alternative Phone Number"),
            Padding(
              padding: padding,
              child: altPhoneNumEditText,
            ),
            headerText("Email Address*"),
            Padding(
              padding: padding,
              child: UtilWidget.txtInputText(
                  "info@tpclick.co.za",
                  AppIconsUsed.emailIcon,
                  _emailController,
                  TextInputType.emailAddress,
                  true),
            ),
            blnEmail
                ? Container()
                : ValidateInput.errorText(ValidateInput.invalidEmail),
            headerText("Password*"),
            Padding(
              padding: padding,
              child: PasswordTextEdit(_passwordController),
            ),
            blnPassword
                ? Container()
                : ValidateInput.errorText(ValidateInput.errorTextPassword),
            headerText("Confirm Password*"),
            Padding(
              padding: padding,
              child: PasswordTextEdit(_confirmPasswordController),
            ),
            blnConfirm
                ? Container()
                : ValidateInput.errorText(
                    ValidateInput.errorTextPasswordConform),
            signUpButton(),
            signUpDisclaimer(),
          ],
        ),
      ),
    );
  }

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

  void changeToHome() {
    UtilWidget.showLoadingDialog(context, "Signing Up...");
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

  bool blnName = true,
      blnPhone = true,
      blnEmail = true,
      blnPassword = true,
      blnConfirm = true;

  bool validateLogin() {
    if (ValidateInput.validateText(_providerNameController.text)) {
      setState(() => blnName = false);
      return false;
    }

    if (ValidateInput.validateText(_phoneNumController.text)) {
      setState(() => blnPhone = false);
      return false;
    }

    if (ValidateInput.validateEmail(_emailController.text)) {
      setState(() => blnEmail = false);
      return false;
    }

    if (ValidateInput.validatePasswordLength(_passwordController.text)) {
      setState(() => blnPassword = false);
      return false;
    }

    if (ValidateInput.validatePasswordMatch(
        _passwordController.text, _confirmPasswordController.text)) {
      setState(() => blnConfirm = false);
      return false;
    }

    return true;
  }

  void setAbsorbState(bool state) {
    setState(() {
      absorb = state;
    });
  }

  Widget signUpButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (validateLogin()) {
              setAbsorbState(true);
              changeToHome();
            } else {
              setAbsorbState(false);
            }
          },
          style: UtilWidget.buttonStyle,
          child: Text(
            "Sign Up",
            style: AppTextStyles.normalBlack(normal, white),
          ),
        ),
      ),
    );
  }

  Widget signUpDisclaimer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
      child: RichText(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.normalBlackSmall(normal, black),
          children: <TextSpan>[
            TextSpan(text: 'By clicking "Sign Up", you agree to our '),
            TextSpan(
                text: 'Terms of Service',
                style: AppTextStyles.normalBlackSmall(normal, Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Terms of Service');
                  }),
            TextSpan(text: ' and that you have read our '),
            TextSpan(
                text: 'Privacy Policy',
                style: AppTextStyles.normalBlackSmall(normal, Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Privacy Policy');
                  }),
          ],
        ),
      ),
    );
  }
}
