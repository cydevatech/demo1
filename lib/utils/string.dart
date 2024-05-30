// ignore_for_file: unused_element

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';

import '../assets/index.dart';

const localeVN = 'vi_VN';
const localeEnUS = 'en_US';
const localeFormat = localeVN;
final _dateFormatDMYcf = DateFormat("yyyy-MM-ddTHH:mm:ss");
final _dateShippingFormat = DateFormat("yyyy-MM-dd");
final _dateFormatDMY = DateFormat("dd/MM/yyyy");
final _dateFormatFull = DateFormat("dd/MM/yyyy HH:mm");
final _timeFormat = DateFormat("HH:mm:ss");
final _numFormatCurrency = NumberFormat('###,###,###.##', localeFormat);
final numFormatter = NumberFormat("#,##0", localeFormat);
const kPriceFormats = ["#,##0", "#,##0", "#,##0.##", "#,##0.##"];
const kPriceUnits = ["₫", "ngàn", "triệu", "tỷ"];
const kPriceUnitsModern = ["₫", "K", "M", "B"];

extension Silly on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  //2020-03-15T09:21:26.000Z
  DateTime? get strToDateCf {
    return isNullOrEmpty ? null : _dateFormatDMYcf.parse(this!, true);
  }

  static bool validateDate({required String date}) {
    final dateFormat = date.stringToDateFull;
    final dateNow = DateTime.now();
    final diff = dateFormat.difference(dateNow);
    return diff.inDays >= 0;
  }

  DateTime get dateOrNow {
    final value = this;
    return !value.isNullOrEmpty
        ? _dateFormatDMY.parse(value!, true)
        : DateTime.now();
  }

  DateTime get stringToDateFull {
    final value = this;
    return !value.isNullOrEmpty
        ? _dateFormatDMY.parse(value!, true)
        : DateTime.now();
  }

  DateTime? get stringToDateDMY {
    final value = this;
    try {
      return _dateFormatDMY.parse(value!, true);
    } catch (_) {
      return null;
    }
  }

  DateTime get stringToDateTIme {
    final value = this;
    return !value.isNullOrEmpty
        ? _dateFormatFull.parse(value!, true)
        : DateTime.now();
  }

  DateTime get timeFormat {
    final value = this;
    return !value.isNullOrEmpty
        ? _timeFormat.parse(value!, true)
        : DateTime.now();
  }

  bool get isUrl {
    final url = this;
    final isUrl = isURL(url);
    return isUrl;
  }

  String get formatPhoneNumber {
    if (isNullOrEmpty == true) return "";

    var phone = this!;
    if (phone.startsWith("+84")) {
      phone = phone.substring(3);
    } else if (phone.startsWith("84")) {
      phone = phone.substring(2);
    }

    if (!phone.startsWith("0") && phone.length < 10) {
      phone = "0$phone";
    }

    return phone;
  }

  bool get isNotNullOrEmpty {
    return this?.isNotEmpty == true;
  }

  bool get isValidEmail {
    return isNotNullOrEmpty && RegExp(RegexCommon.emailRegex).hasMatch(this!);
  }

  bool get isValidPhone {
    return isNotNullOrEmpty && RegExp(RegexCommon.phoneRegex).hasMatch(this!);
  }

  String get removeAllHtmlTags {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return this?.replaceAll(exp, '').trim() ?? '';
  }
}

String formatSecondsToMinutes(int seconds) {
  int minutes = seconds ~/ 60; // Chia cho 60 để tính số phút
  int remainingSeconds = seconds % 60; // Lấy phần dư để tính số giây còn lại

  String formattedTime =
      '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';

  return formattedTime;
}

extension Dilly on DateTime? {
  DateTime? get stripTime =>
      (this != null) ? DateTime(this!.year, this!.month, this!.day) : null;
  String get formatShipping =>
      (this != null) ? _dateShippingFormat.format(this!) : "";
  String get formatDMY => (this != null) ? _dateFormatDMY.format(this!) : "";
  String get formatDMYHM => (this != null) ? _dateFormatFull.format(this!) : "";
  String get formatHM =>
      (this != null) ? DateFormat("HH:mm").format(this!) : "";
  String get formatHM_12 =>
      (this != null) ? DateFormat("HH:mm a").format(this!) : "";
  String yMed(String local) {
    return (this != null)
        ? DateFormat("EEEE, dd/MM/yyyy", local).format(this!)
        : "";
  }
}

extension Nilly on num {
  num get safeNum => this;

  String formatUnitPrice({
    String numSuffix = "",
    List<String> units = kPriceUnits,
  }) {
    if (this <= 0) return "${formatPrice()}$numSuffix ${units[0]}";

    final n = (log(this) / log(1000)).floor().clamp(0, units.length - 1);
    double p = this / pow(1000, n);
    String format = kPriceFormats[n];
    final str = "${p.formatPrice(format: format)}$numSuffix ${units[n]}";
    return str;
  }

  String formatPrice({String format = '#,##0.##', String unit = ''}) {
    try {
      return '$unit${NumberFormat(format, localeFormat).format(this)}';
    } catch (err) {
      debugPrint("unable to format string double $this - $err");
    }
    return '';
  }
}

extension IterableExt<T> on Iterable<T> {
  Iterable<T> listByToggle(T item, [bool prepend = true]) {
    if (this.contains(item)) {
      //remove
      return [...where((element) => element != item)];
    } else {
      //insert
      return prepend ? [item, ...this] : [...this, item];
    }
  }
}

String formatMoney(double x) {
  String formattedAmount = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'đ',
  ).format(x);
  return formattedAmount;
}

String formatMoneys(int x) {
  String formattedAmount = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'đ',
  ).format(x);
  return formattedAmount;
}

String formatDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
  return formattedDate;
}

bool validateDate({required String date}) {
  final dateFormat = date.stringToDateFull;
  final dateNow = DateTime.now();
  final diff = dateFormat.difference(dateNow);
  return diff.inDays >= 0;
}

String removeLastCharacter(String str) {
  if (str != '') {
    return str.substring(0, str.length - 1);
  }
  return str;
}

class AppConfig {
  static const String languageDefault = "vi";
  static final Map<String, AppLanguage> languagesSupported = {
    // 'vi': AppLanguage("Vietnam", vietnam()),
    // 'en': AppLanguage("English", english()),
  };
}

class AppLanguage {
  final String name;
  final Map<String, String> values;

  AppLanguage(this.name, this.values);
}

String parseTimeOrder(String time) {
  DateTime dateTime = DateFormat("HH:mm:ss dd/MM/yyyy").parse(time);

  return DateFormat("HH:mm").format(dateTime);
}

String parseTimeVoucher(String time) {
  DateTime dateTime = DateTime.parse(time);
  String formattedTime = DateFormat("HH:mm dd/MM/yyyy").format(dateTime);

  return formattedTime;
}
