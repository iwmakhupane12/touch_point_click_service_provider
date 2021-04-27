import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:country_calling_code_picker/country.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appIconsUsed.dart';
import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appTextStyles.dart';
import 'package:touch_point_click_service_provider/src/components/baseWidget.dart';
import 'package:touch_point_click_service_provider/src/components/dateTimeConvertFunctions.dart';
import 'package:touch_point_click_service_provider/src/components/passwordTextEdit.dart';
import 'package:touch_point_click_service_provider/src/components/phoneNumEditText.dart';
import 'package:touch_point_click_service_provider/src/components/utilWidget.dart';
import 'package:touch_point_click_service_provider/src/components/validateInput.dart';
import 'package:touch_point_click_service_provider/src/screens/home.dart';
import 'package:touch_point_click_service_provider/src/services/userAuth.dart';

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
  UserAuth _userAuth = new UserAuth();

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
                    "Service Provider's Name${ValidateInput.errorTextNull}"),
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
    Navigator.pop(context); //Pop loading dialog

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  bool blnName = true,
      blnPhone = true,
      blnEmail = true,
      blnPassword = true,
      blnConfirm = true;

  bool validateLogin() {
    bool valide = false;

    if (!ValidateInput.validateText(_providerNameController.text)) {
      setState(() => blnName = false);
    } else {
      setState(() => blnName = true);
    }

    if (!ValidateInput.validateText(_phoneNumController.text)) {
      setState(() => blnPhone = false);
    } else {
      setState(() => blnPhone = true);
    }

    if (!ValidateInput.validateEmail(_emailController.text)) {
      setState(() => blnEmail = false);
    } else {
      setState(() => blnEmail = true);
    }

    if (!ValidateInput.validatePasswordLength(_passwordController.text)) {
      setState(() => blnPassword = false);
    } else {
      setState(() => blnPassword = true);
    }

    if (!ValidateInput.validatePasswordMatch(
        _passwordController.text, _confirmPasswordController.text)) {
      setState(() => blnConfirm = false);
    } else {
      setState(() => blnConfirm = true);
    }

    if (blnName && blnPhone && blnEmail && blnPassword && blnConfirm)
      valide = true;

    return valide;
  }

  void setAbsorbState(bool state) {
    setState(() {
      absorb = state;
    });
  }

  String name, phone, altPhone, email, password, regDate;

  void setRegisterVars() {
    name = _providerNameController.text.trim();
    phone = replacePhoneZeroWithCode(
        _phoneNumController.text.trim(), phoneNumEditText.country);

    if (_altPhoneNumController.text != "") {
      altPhone = replacePhoneZeroWithCode(
          _altPhoneNumController.text.trim(), altPhoneNumEditText.country);
    }

    email = _emailController.text.trim().toLowerCase();
    password = _passwordController.text.trim();
    regDate = DateTimeConvert.dateFormated(DateTime.now()) +
        " @ " +
        DateTimeConvert.addZeroToTime(
            "${TimeOfDay.now().hour}", "${TimeOfDay.now().minute}");
  }

  String replacePhoneZeroWithCode(String txtNumber, Country selectedCountry) {
    if (txtNumber.startsWith('0')) {
      return txtNumber.replaceFirst('0', selectedCountry.callingCode);
    } else {
      return txtNumber;
    }
  }

  Widget signUpButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            if (validateLogin()) {
              UtilWidget.showLoadingDialog(context, "Signing Up...");
              setAbsorbState(true);
              setRegisterVars();
              dynamic result = await _userAuth.signUpEmailPassword(
                  email, password, name, phone, altPhone, regDate);

              if (result != null) {
                if (result == 'weak-password') {
                  print('The password provided is too weak.');
                  Navigator.pop(context);
                  setAbsorbState(false);
                } else if (result == 'email-already-in-use') {
                  print('The account already exists for that email.');
                  Navigator.pop(context);
                  setAbsorbState(false);
                } else if (result == "unknown") {
                  print('Unknown Error Occurred.');
                  Navigator.pop(context);
                  setAbsorbState(false);
                } else if (result == "Success") {
                  changeToHome();
                }
              }
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
