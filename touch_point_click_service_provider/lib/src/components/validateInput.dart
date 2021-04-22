import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';

class ValidateInput {
  static String invalidEmail = 'Invalid email address(e.g. info@tpclick.co.za)';
  static String errorTextNull = " cannot be empty";
  static String errorTextPassword = 'Password must be 8 characters and more';
  static String errorTextPasswordConform = 'Passwords do not match';

  static String incorrectCredintials =
      'Email and Password do not match any of our records';
  static String userEmailExists = 'Email address entered already exists';

  static bool validateEmail(String txtEmailCon) {
    return EmailValidator.validate(txtEmailCon);
  }

  static bool validateText(String txtCheck) {
    bool textCorrect = false;

    if (txtCheck.length > 0) textCorrect = true;

    return textCorrect;
  }

  //Validate password length
  static bool validatePasswordLength(String txtCheck) {
    bool passwordLength = false;

    if (txtCheck.length >= 8) passwordLength = true;

    return passwordLength;
  }

  //Validate if password and confirm password match
  static bool validatePasswordMatch(
      String txtPasswordCheck, String txtConfirmPassCheck) {
    bool passwordMatch = false;

    if (txtPasswordCheck.compareTo(txtConfirmPassCheck) == 0)
      passwordMatch = true;

    return passwordMatch;
  }

  static Widget errorText(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        errorMessage,
        style: AppTextStyles.normalBlackSmall(FontWeight.normal, Colors.red),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  //validate number
  static bool isNumeric(String str) {
    if (str == "") {
      return false;
    }
    return int.tryParse(str) != null;
  }

  //Validate double
  static bool isDouble(String str) {
    if (str == "") {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
