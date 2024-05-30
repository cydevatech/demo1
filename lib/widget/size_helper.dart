import 'package:demo1/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SizeHelper {
  static BoxConstraints mainBoxConstraints() {
    if (GetPlatform.isMobile) {
      return BoxConstraints(
          maxWidth: MediaQuery.of(navigatorKey.currentContext!).size.width,
          maxHeight: MediaQuery.of(navigatorKey.currentContext!).size.height);
    }
    return BoxConstraints(
        maxWidth: mainSizeWidth(), maxHeight: mainSizeHeight());
  }

  static double mainSizeWidth() {
    if (GetPlatform.isMobile) {
      return MediaQuery.of(navigatorKey.currentContext!).size.width;
    }
    return 290;
  }

  static double mainSizeHeight() {
    if (GetPlatform.isMobile) {
      return MediaQuery.of(navigatorKey.currentContext!).size.height;
    }
    return 650;
  }

  static double mainMarginBottomModal() {
    if (GetPlatform.isMobile) {
      return 0;
    }
    return (MediaQuery.of(navigatorKey.currentContext!).size.height - 650) / 2 +
        10;
  }

  static BorderRadius borderRadiusBottomModal() {
    if (GetPlatform.isMobile) {
      return BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      );
    }
    return BorderRadius.only(
      topLeft: Radius.circular(25),
      topRight: Radius.circular(25),
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    );
  }

  static double width(double w) {
    if (GetPlatform.isMobile) {
      return w;
    }
    return w * 0.8;
  }

  static double height(double h) {
    if (GetPlatform.isMobile) {
      return h;
    }
    return h * 0.8;
  }
}
