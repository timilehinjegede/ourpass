import 'package:flutter/material.dart';
import 'package:our_pass/core/constants/constants.dart';

// base theme
final baseTheme = ThemeData.light();

// base border
const outlineInputBorderBase = UnderlineInputBorder(
  borderRadius: BorderRadius.zero,
  borderSide: BorderSide.none,
);

final appTheme = ThemeData(
  scaffoldBackgroundColor: appColors.background,
  backgroundColor: appColors.black.withOpacity(.5),
  primaryColor: appColors.purple,
  appBarTheme: baseTheme.appBarTheme.copyWith(
    backgroundColor: appColors.background,
    elevation: 0,
    foregroundColor: appColors.black,
  ),
  colorScheme: baseTheme.colorScheme.copyWith(
    secondary: appColors.purple,
  ),
  dividerColor: appColors.darkGrey,
  brightness: Brightness.light,
  disabledColor: appColors.red,
  progressIndicatorTheme: baseTheme.progressIndicatorTheme.copyWith(
    color: appColors.purple,
  ),
  checkboxTheme: baseTheme.checkboxTheme.copyWith(
    fillColor: MaterialStateProperty.all(
      appColors.purple,
    ),
    side: BorderSide(
      color: appColors.darkGrey.withOpacity(.7),
    ),
  ),
  inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    filled: true,
    fillColor: appColors.background,
    border: outlineInputBorderBase,
    enabledBorder: outlineInputBorderBase,
    focusedBorder: outlineInputBorderBase,
    labelStyle: TextStyle(
      fontSize: 14,
      color: appColors.darkGrey,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      color: appColors.darkGrey,
    ),
  ),
  textTheme: baseTheme.copyWith().textTheme.apply(
        fontFamily: 'OpenSans',
        bodyColor: appColors.black,
      ),
);
