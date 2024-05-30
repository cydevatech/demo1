import 'package:flutter/material.dart';

class AppSafeArea extends SafeArea {
  const AppSafeArea({
    Key? key,
    required Widget child,
    bool left = true,
    bool top = true,
    bool right = true,
    bool bottom = true,
    bool maintainBottomViewPadding = false,
    EdgeInsets? minimum,
  }) : super(
          key: key,
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          child: child,
          maintainBottomViewPadding: maintainBottomViewPadding,
          minimum: minimum ?? const EdgeInsets.only(bottom: 12),
        );
}
