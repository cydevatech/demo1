import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'index.dart';

// const kFontFamily = "SFPro";

class CommonThemeData {
  CommonThemeData._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    platform: TargetPlatform.iOS,
    // fontFamily: kFontFamily,
    primaryColor: blackColor,
    scaffoldBackgroundColor: blackColor,
    highlightColor: Colors.transparent,
    indicatorColor: sonicSilverColor,
    textTheme: commonTextTheme,
    appBarTheme: const AppBarTheme(
      color: blackColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 20.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: commonTextTheme.bodySmall,
      unselectedLabelStyle: commonTextTheme.bodySmall,
    ),

    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    buttonTheme: const ButtonThemeData(
      alignedDropdown: true,
      height: 44,
      padding: EdgeInsets.all(10.0),
    ),
    checkboxTheme: const CheckboxThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
    cardTheme: const CardTheme(
      color: blackColor,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    // listTileTheme: ListTileThemeData(
    //   titleTextStyle: text16,
    //   contentPadding: EdgeInsets.zero,
    //   visualDensity: const VisualDensity(
    //     horizontal: VisualDensity.minimumDensity,
    //     vertical: VisualDensity.minimumDensity,
    //   ),
    // ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: blackColor,
      iconSize: 28.0,
      sizeConstraints: BoxConstraints.tightFor(width: 52.0, height: 52.0),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      modalBackgroundColor: Colors.white,
      modalBarrierColor: Colors.black.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),
    tabBarTheme: TabBarTheme(
      overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
        return Colors.transparent;
      }),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: NoShadowCupertinoPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
  );
}
