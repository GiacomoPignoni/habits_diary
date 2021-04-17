import 'package:flutter/material.dart';
import 'package:project_habits/themes/purple_green.dart';
import 'package:project_habits/themes/orange_blue.dart';
import 'package:project_habits/themes/yellow_blue.dart';

const Color WHITE = Colors.white;
const Color BWHITE = Color(0xffF7F7F7);
const Color GREY = Color(0xFFE6E6EA);
const Color BGREY = Color(0xFF404040);
const Color BLACK = Color(0xFF313131);
const Color BBLACK = Color(0xFF000000);

enum ThemeColors {
  yellowBlue,
  purpleGreen,
  orangeBlue
}

List<Color> getColors(ThemeColors color) {
  switch(color) {
    case ThemeColors.yellowBlue:
      return [YELLOW_BLUE_THEME.primary, YELLOW_BLUE_THEME.accent, YELLOW_BLUE_THEME.hightlight];
    case ThemeColors.purpleGreen:
      return [PURPLE_GREEN_THEME.primary, PURPLE_GREEN_THEME.accent, PURPLE_GREEN_THEME.hightlight];
    case ThemeColors.orangeBlue:
      return [ORANGE_BLUE_THEME.primary, ORANGE_BLUE_THEME.accent, ORANGE_BLUE_THEME.hightlight];
  }
}

getLightTheme(ThemeColors color) {
  switch(color) {
    case ThemeColors.yellowBlue:
      return lightTheme.copyWith(
        primaryColor: YELLOW_BLUE_THEME.primary,
        accentColor: YELLOW_BLUE_THEME.accent,
        highlightColor: YELLOW_BLUE_THEME.hightlight,
      );
    case ThemeColors.purpleGreen:
      return lightTheme.copyWith(
        primaryColor: PURPLE_GREEN_THEME.primary,
        accentColor: PURPLE_GREEN_THEME.accent,
        highlightColor: PURPLE_GREEN_THEME.hightlight,
      );
    case ThemeColors.orangeBlue:
      return lightTheme.copyWith(
        primaryColor: ORANGE_BLUE_THEME.primary,
        accentColor: ORANGE_BLUE_THEME.accent,
        highlightColor: ORANGE_BLUE_THEME.hightlight,
      );
  }
}

getDarkTheme(ThemeColors color) {
  switch(color) {
    case ThemeColors.yellowBlue:
      return darkTheme.copyWith(
        primaryColor: YELLOW_BLUE_THEME.primary,
        accentColor: YELLOW_BLUE_THEME.accent,
        highlightColor: YELLOW_BLUE_THEME.hightlight,
        hintColor: YELLOW_BLUE_THEME.accent
      );
    case ThemeColors.purpleGreen:
      return darkTheme.copyWith(
        primaryColor: PURPLE_GREEN_THEME.primary,
        accentColor: PURPLE_GREEN_THEME.accent,
        highlightColor: PURPLE_GREEN_THEME.hightlight,
        hintColor: PURPLE_GREEN_THEME.accent
      );
    case ThemeColors.orangeBlue:
      return darkTheme.copyWith(
        primaryColor: ORANGE_BLUE_THEME.primary,
        accentColor: ORANGE_BLUE_THEME.accent,
        highlightColor: ORANGE_BLUE_THEME.hightlight,
        hintColor:  ORANGE_BLUE_THEME.accent
      );
  }
}

final lightTheme = ThemeData(
  backgroundColor: BWHITE,
  scaffoldBackgroundColor: BWHITE,
  primaryColorLight: WHITE,
  primaryColorDark: BLACK,
  shadowColor: GREY,
  fontFamily: "Kodchasan",
  textTheme: TextTheme(
    headline1: TextStyle(
      color: WHITE,
      fontSize: 28
    ),
    headline2: TextStyle(
      color: BLACK,
      fontSize: 22,
      fontWeight: FontWeight.bold
    ),
    headline3: TextStyle(
      color: BLACK,
      fontSize: 20
    ),
    headline4: TextStyle(
      color: WHITE,
      fontSize: 18
    ),
    bodyText2: TextStyle(
      color: BLACK,
      fontSize: 18
    ),
    subtitle1: TextStyle(
      color: BLACK,
      fontSize: 12
    ),
    subtitle2: TextStyle(
      color: BLACK,
      fontSize: 16
    ),
    button: TextStyle(
      fontSize: 18,
      decoration: TextDecoration.underline
    ),
  ),
  iconTheme: IconThemeData(
    color: WHITE,
    size: 24
  )
);

final darkTheme = ThemeData(
  backgroundColor: BLACK,
  scaffoldBackgroundColor: BBLACK,
  primaryColorLight: BLACK,
  primaryColorDark: WHITE,
  shadowColor: BGREY,
  fontFamily: "Kodchasan",
  unselectedWidgetColor: WHITE,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: WHITE,
      fontSize: 28
    ),
    headline2: TextStyle(
      color: WHITE,
      fontSize: 22,
      fontWeight: FontWeight.bold
    ),
    headline3: TextStyle(
      color: WHITE,
      fontSize: 20
    ),
    headline4: TextStyle(
      color: WHITE,
      fontSize: 18
    ),
    bodyText2: TextStyle(
      color: WHITE,
      fontSize: 18
    ),
    subtitle1: TextStyle(
      color: WHITE,
      fontSize: 12
    ),
    subtitle2: TextStyle(
      color: WHITE,
      fontSize: 16
    ),
    button: TextStyle(
      fontSize: 18,
      decoration: TextDecoration.underline
    ),
  ),
  iconTheme: IconThemeData(
    color: WHITE,
    size: 24
  )
);