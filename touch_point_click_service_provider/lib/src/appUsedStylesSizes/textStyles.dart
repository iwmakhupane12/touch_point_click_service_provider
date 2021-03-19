import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  static TextStyle bodyBold() {
    return GoogleFonts.oswald(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  static TextStyle bodyBoldUnderLined() {
    return GoogleFonts.oswald(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle bodyNormalBlack() {
    return GoogleFonts.oswald(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 20,
    );
  }

  static TextStyle bodyNormalBlackSmallBold() {
    return GoogleFonts.oswald(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }

  static TextStyle bodyNormalBlackSmallSmall() {
    return GoogleFonts.oswald(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
  }

  static TextStyle bodyNormalWhiteSmallSmall() {
    return GoogleFonts.oswald(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
  }

  static TextStyle bodyNormalWhiteSmall() {
    return GoogleFonts.oswald(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 16,
    );
  }

  static TextStyle bodyNormalBlackSmall() {
    return GoogleFonts.oswald(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 16,
    );
  }

  static TextStyle bodyNormalBlueSmall() {
    return GoogleFonts.oswald(
      color: Colors.blue[900],
      fontWeight: FontWeight.normal,
      fontSize: 16,
    );
  }

  static TextStyle bodyNormalBlue() {
    return GoogleFonts.oswald(
      color: txtCursorColor,
      fontWeight: FontWeight.normal,
      fontSize: 20,
    );
  }

  static TextStyle bodyBoldBlueSmall() {
    return GoogleFonts.oswald(
      color: txtCursorColor,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }

  static TextStyle bodyNormalVerified(bool isOrNotVerified) {
    return GoogleFonts.oswald(
      color: isOrNotVerified ? Colors.greenAccent[400] : Colors.red[800],
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
  }

  static TextStyle bodyNormalWhite() {
    return GoogleFonts.oswald(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 20,
    );
  }

  static TextStyle bodyNormalGreyish() {
    return GoogleFonts.oswald(
      color: Colors.black54,
      fontWeight: FontWeight.normal,
      fontSize: 20,
    );
  }

  static TextStyle bodyNormalGreyishSmall() {
    return GoogleFonts.oswald(
      color: Colors.black54,
      fontWeight: FontWeight.normal,
      fontSize: 16,
    );
  }

  static TextStyle bodyNormalGreyishNotes() {
    return GoogleFonts.oswald(
      color: Colors.black54,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
  }

  static TextStyle confirmNormalGreyishSmall() {
    return GoogleFonts.oswald(
      color: Colors.black54,
      fontWeight: FontWeight.normal,
      fontSize: 16,
    );
  }

  static TextStyle bodyBlackDrawer() {
    return GoogleFonts.oswald(
      color: Colors.black,
      fontSize: 16,
    );
  }

  static Widget returnTextFieldHeader(String strHeader, Icon iconHeader) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: iconHeader,
          ),
          Text(strHeader, style: AppTextStyles.bodyNormalBlack()),
        ],
      ),
    );
  }

  static Widget returnBoldTextFieldHeader(String strHeader, Icon iconHeader) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: iconHeader,
        ),
        Text(strHeader, style: AppTextStyles.bodyBold()),
      ],
    );
  }

  static Widget returnNormalTextFieldHeader(String strHeader, Icon iconHeader) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: iconHeader,
        ),
        Text(strHeader, style: AppTextStyles.bodyNormalBlack()),
      ],
    );
  }

  static Widget returnNormalBlueTextFieldHeader(
      String strHeader, Icon iconHeader) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: iconHeader,
        ),
        Text(strHeader, style: AppTextStyles.bodyNormalBlue()),
      ],
    );
  }

  static Color txtCursorColor = Color.fromRGBO(80, 145, 205, 1);
  //static Color txtCursorColor = Color.fromRGBO(0, 145, 255, 1);
  static Color bodyBackgroundColor = Colors.grey[200];
  static Color textHintColor = Colors.grey[300];

  static Widget cliprrectForApp(Container bodyContainer) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: bodyContainer,
    );
  }

  static EdgeInsets txtPadding = EdgeInsets.only(
    left: 25.0,
    right: 25.0,
    top: 10.0,
    bottom: 10.0,
  );

  static InputDecoration txtProfileInputDecor(
      String txtHintText, Icon txtPrefixIcon, IconButton txtSuffixIconButton) {
    return InputDecoration(
      hintText: txtHintText,
      hintStyle: TextStyle(color: AppTextStyles.textHintColor),
      suffixIcon: txtSuffixIconButton,
      prefixIcon: txtPrefixIcon,
    );
  }
}
