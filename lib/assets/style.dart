import 'package:flutter/material.dart';

import 'index.dart';

TextStyle get fontApp => TextStyle(
      // fontFamily: kFontFamily,
      fontWeight: FontWeight.normal,
      fontSize: 14.sp,
      color: Colors.black,
      decoration: TextDecoration.none,
    );
TextStyle get text8 => fontApp.copyWith(fontSize: 8.sp);

TextStyle get text10 => fontApp.copyWith(fontSize: 10.sp);

TextStyle get text11 => fontApp.copyWith(fontSize: 11.sp);

TextStyle get text12 => fontApp.copyWith(fontSize: 12.sp);

TextStyle get text13 => fontApp.copyWith(fontSize: 13.sp);

TextStyle get text14 => fontApp.copyWith(fontSize: 14.sp);

TextStyle get text15 => fontApp.copyWith(fontSize: 15.sp);

TextStyle get text16 => fontApp.copyWith(fontSize: 16.sp);

TextStyle get text17 => fontApp.copyWith(fontSize: 17.sp);

TextStyle get text18 => fontApp.copyWith(fontSize: 18.sp);

TextStyle get text20 => fontApp.copyWith(fontSize: 20.sp);

TextStyle get text22 => fontApp.copyWith(fontSize: 22.sp);

TextStyle get text24 => fontApp.copyWith(fontSize: 24.sp);

TextStyle get text26 => fontApp.copyWith(fontSize: 26.sp);

TextStyle get text28 => fontApp.copyWith(fontSize: 28.sp);

TextStyle get text30 => fontApp.copyWith(fontSize: 30.sp);

TextStyle get text32 => fontApp.copyWith(fontSize: 32.sp);

TextStyle get text34 => fontApp.copyWith(fontSize: 34.sp);

TextStyle get text38 => fontApp.copyWith(fontSize: 38.sp);

TextStyle get text40 => fontApp.copyWith(fontSize: 40.sp);

TextStyle get text48 => fontApp.copyWith(fontSize: 48.sp);

TextStyle get text50 => fontApp.copyWith(fontSize: 50.sp);

TextStyle get text52 => fontApp.copyWith(fontSize: 52.sp);

TextStyle get text60 => fontApp.copyWith(fontSize: 60.sp);

TextStyle get text65 => fontApp.copyWith(fontSize: 65.sp);

TextStyle get text80 => fontApp.copyWith(fontSize: 80.sp);

TextStyle get text100 => fontApp.copyWith(fontSize: 100.sp);

extension TextStyleExt on TextStyle {
  //Decoration style
  TextStyle get underLine => copyWith(decoration: TextDecoration.underline);

  TextStyle get overLine => copyWith(decoration: TextDecoration.overline);

  TextStyle get thickNess2 => copyWith(decorationThickness: 2);

  //Weight style
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get bold800 => copyWith(fontWeight: FontWeight.w800);

  //height style
  TextStyle get height0_22Per => copyWith(height: 0.22);

  TextStyle get height17Per => copyWith(height: 1.7);

  TextStyle get height18Per => copyWith(height: 1.8);

  TextStyle get height19Per => copyWith(height: 1.9);

  TextStyle get height20Per => copyWith(height: 2.0);

  TextStyle get height21Per => copyWith(height: 2.1);

  TextStyle get height22Per => copyWith(height: 2.2);

  //Color style
  TextStyle get black => copyWith(color: blackColor);
  TextStyle get textColor => copyWith(color: const Color(0xff7D7D7D));
  TextStyle get primary => copyWith(color: primaryColor);
  TextStyle get error => copyWith(color: Colors.red);
  TextStyle get red => copyWith(color: Colors.red);
  TextStyle get white => copyWith(color: whiteColor);
  TextStyle get grey => copyWith(color: Colors.grey);
  TextStyle get backgroundColor => copyWith(color: const Color(0xff292152));
  TextStyle get blue => copyWith(color: Colors.blue);
  TextStyle get green => copyWith(color: Colors.green);
}

TextTheme get commonTextTheme => TextTheme(
      /// title 1
      titleLarge: fontApp.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 24.sp,
      ),

      /// title 2
      titleMedium: fontApp.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
      ),

      /// title 3 /// suntitle 1
      titleSmall: fontApp.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
      ),

      /// subtitle 1.1
      headlineLarge: fontApp.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18.sp,
      ),

      /// subtitle 2
      headlineMedium: fontApp.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),

      /// paragraph 1
      headlineSmall: fontApp.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),

      /// paragraph 2
      bodyLarge: fontApp.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
      ),

      /// paragraph 2.1
      bodyMedium: fontApp.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),

      /// paragraph 2.2
      bodySmall: fontApp.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 14.sp,
      ),

      /// button 1
      displayLarge: fontApp.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),

      /// button 1.1
      displayMedium: fontApp.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),

      /// button 2
      displaySmall: fontApp.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),

      /// caption 1
      labelLarge: fontApp.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
      ),

      /// caption 1.1
      labelMedium: fontApp.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 12.sp,
      ),

      /// label
      labelSmall: fontApp.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 10.sp,
      ),
    );

TextTheme textTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

TextTheme primaryTextTheme(BuildContext context) {
  return Theme.of(context).primaryTextTheme;
}
