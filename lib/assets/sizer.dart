import 'dart:math';
import 'dart:ui' as ui;

import 'package:demo1/main.dart';
import 'package:flutter/material.dart';

///The number of device pixels for each logical pixel.
double get pixelRatio => ui.window.devicePixelRatio;

Size get size => ui.window.physicalSize / pixelRatio;

const guidelineBaseWidth = 375;
const guidelineBaseHeight = 812;

double kButtonRadius = 16;

Size sizer = MediaQuery.of(navigatorKey.currentContext!).size;

double get scaleWidth => size.width / guidelineBaseWidth;

double get scaleHeight => size.height / guidelineBaseHeight;

double get scaleText => min(scaleWidth, scaleHeight);

extension ScreenExtension on num {
  double get w => this * scaleWidth; // Width Scale
  double get h => this * scaleHeight; // Height Scale
  double get sp => this * scaleText; // Text Scale
  double get r => this * scaleText; // Radius Scale
}
