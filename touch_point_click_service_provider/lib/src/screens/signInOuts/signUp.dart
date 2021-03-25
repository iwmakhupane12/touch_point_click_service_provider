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

class SignUp extends StatefulWidget {
  final Country country;

  SignUp(this.country);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _providerName,
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

  @override
  void initState() {
    super.initState();
    initControllers();
    _country = widget.country;

    phoneNumEditText = PhoneNumEditText(_phoneNumController, _country);
    altPhoneNumEditText = PhoneNumEditText(_altPhoneNumController, _country);
  }

  void initControllers() {
    _providerName = TextEditingController();
    _phoneNumController = TextEditingController();
    _altPhoneNumController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _providerName.dispose();
    _phoneNumController.dispose();
    _altPhoneNumController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget.clipedBase(
      ListView(
        children: [
          headerText("Service Provider Name"),
          Padding(
            padding: padding,
            child: UtilWidget.txtInputText(
                "Touchpoint Click Pty(Ltd)",
                AppIconsUsed.personIcon,
                _providerName,
                TextInputType.text,
                true),
          ),
          headerText("Phone Number"),
          Padding(
            padding: padding,
            child: phoneNumEditText,
          ),
          headerText("Alternative Phone Number"),
          Padding(
            padding: padding,
            child: altPhoneNumEditText,
          ),
          headerText("Email Address"),
          Padding(
            padding: padding,
            child: UtilWidget.txtInputText(
                "info@tpclick.co.za",
                AppIconsUsed.emailIcon,
                _emailController,
                TextInputType.emailAddress,
                true),
          ),
          headerText("Password"),
          Padding(
            padding: padding,
            child: PasswordTextEdit(_passwordController),
          ),
          headerText("Coonfirm Password"),
          Padding(
            padding: padding,
            child: PasswordTextEdit(_confirmPasswordController),
          ),
          signUpButton(),
          signUpDisclaimer(),
        ],
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

  void checkControllers() {
    print("Name: ${_providerName.text}");
    print("Phone Number: ${_phoneNumController.text}");
    print("Alternative Phone Number: ${_altPhoneNumController.text}");
    print("Email Address: ${_emailController.text}");
    print("Password: ${_passwordController.text}");
    print("Confirm Password: ${_confirmPasswordController.text}");
  }

  Widget signUpButton() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            //changeScreen();
            checkControllers();
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
