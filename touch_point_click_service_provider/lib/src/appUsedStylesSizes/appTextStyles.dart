import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:touch_point_click_service_provider/src/appUsedStylesSizes/appColors.dart';

abstract class AppTextStyles {
  //Font sizes
  static final double _normalFontSize = 20.0;
  static final double _normalSmallFontSize = 16.0;
  static final double _normalSmallSmallFontSize = 14.0;

  //Normal styles
  static TextStyle normalLarge(
      FontWeight setFontWeight, Color normalBlackWhite) {
    return GoogleFonts.oswald(
      color: normalBlackWhite,
      fontWeight: setFontWeight,
      fontSize: 28,
    );
  }

  static TextStyle normalCompanyName(
      FontWeight setFontWeight, Color normalBlackWhite) {
    return GoogleFonts.oswald(
      color: normalBlackWhite,
      fontWeight: setFontWeight,
      fontSize: 24,
    );
  }

  static TextStyle normalBlack(
      FontWeight setFontWeight, Color normalBlackWhite) {
    return GoogleFonts.oswald(
      color: normalBlackWhite,
      fontWeight: setFontWeight,
      fontSize: _normalFontSize,
    );
  }

  static TextStyle normalBlue(FontWeight setFontWeight) {
    return GoogleFonts.oswald(
      color: AppColors.appBlueColor,
      fontWeight: setFontWeight,
      fontSize: _normalFontSize,
    );
  }

  //Normal Small Styles
  static TextStyle normalBlackSmall(
      FontWeight setFontWeight, Color normalBlackWhite) {
    return GoogleFonts.oswald(
      color: normalBlackWhite,
      fontWeight: setFontWeight,
      fontSize: _normalSmallFontSize,
    );
  }

  //Normal Small Blue Styles
  static TextStyle normalBlueSmall(FontWeight setFontWeight) {
    return GoogleFonts.oswald(
      color: AppColors.appBlueColor,
      fontWeight: setFontWeight,
      fontSize: _normalSmallFontSize,
    );
  }

  //Normal SmallSmall Styles
  static TextStyle normalBlackSmallSmall(
      FontWeight setFontWeight, Color normalBlackWhite) {
    return GoogleFonts.oswald(
      color: normalBlackWhite,
      fontWeight: setFontWeight,
      fontSize: _normalSmallSmallFontSize,
    );
  }

  //Underlined styles
  static TextStyle normalBlackUnderLined(
      FontWeight setFontWeight, Color normalBlackWhite) {
    return GoogleFonts.oswald(
      color: normalBlackWhite,
      fontWeight: setFontWeight,
      fontSize: _normalFontSize,
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle bodyNormalVerified(bool isOrNotVerified) {
    return GoogleFonts.oswald(
      color: isOrNotVerified ? Colors.greenAccent[400] : Colors.red[800],
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
  }

  //Normal Greyish Color
  static TextStyle normalGreyish() {
    return GoogleFonts.oswald(
      color: Colors.black54,
      fontWeight: FontWeight.normal,
      fontSize: _normalFontSize,
    );
  }

  //Small Greyish Color
  static TextStyle normalGreyishSmall() {
    return GoogleFonts.oswald(
      color: Colors.black54,
      fontWeight: FontWeight.normal,
      fontSize: _normalSmallFontSize,
    );
  }

  //Small Small Greyish Color
  static TextStyle normalGreyishSmallSmall() {
    return GoogleFonts.oswald(
      color: Colors.black54,
      fontWeight: FontWeight.normal,
      fontSize: _normalSmallSmallFontSize,
    );
  }

  static Widget normalText(
      String text, FontWeight fontWeight, Color color, int lines) {
    return Text(
      text,
      style: AppTextStyles.normalBlack(fontWeight, color),
      overflow: TextOverflow.ellipsis,
      maxLines: lines,
    );
  }

  static Widget normalSmallText(
      String text, FontWeight fontWeight, Color color, int lines) {
    return Text(
      text,
      style: AppTextStyles.normalBlackSmall(fontWeight, color),
      overflow: TextOverflow.ellipsis,
      maxLines: lines,
    );
  }

  static Widget normalSmallSmallText(
      String text, FontWeight fontWeight, Color color, int lines) {
    return Text(
      text,
      style: AppTextStyles.normalBlackSmallSmall(fontWeight, color),
      overflow: TextOverflow.ellipsis,
      maxLines: lines,
    );
  }
}
