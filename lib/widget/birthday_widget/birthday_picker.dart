import 'dart:math';

import 'package:demo1/assets/index.dart';
import 'package:flutter/material.dart';

import '../../storages/storage.dart';

class BirthdayPicker extends StatefulWidget {
  final DateTime? initialDateTime;
  final Function(DateTime) onSelectedItemChanged;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  BirthdayPicker({
    Key? key,
    this.initialDateTime,
    required this.onSelectedItemChanged,
    this.maximumDate,
    this.minimumDate,
  }) : super(key: key);

  @override
  State<BirthdayPicker> createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {
  late DateTime initialDateTime;
  DateTime maximumDate = DateTime.now();
  DateTime minimumDate = DateTime(DateTime.now().year - 65);
  late int _currMonth, _currYear, _currDay;
  DateTime selectedDate = DateTime(DateTime.now().year - 18);
  List<int> solarMonthsOf31Days = const <int>[1, 3, 5, 7, 8, 10, 12];
  HiveStorage hive = HiveStorage();
  List<String> vietnameseMonthList = [
    'Tháng 01',
    'Tháng 02',
    'Tháng 03',
    'Tháng 04',
    'Tháng 05',
    'Tháng 06',
    'Tháng 07',
    'Tháng 08',
    'Tháng 09',
    'Tháng 10',
    'Tháng 11',
    'Tháng 12'
  ];
  List<String> englishMonthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  @override
  void initState() {
    if (widget.maximumDate != null) maximumDate = widget.maximumDate!;
    if (widget.minimumDate != null) minimumDate = widget.minimumDate!;
    if (widget.initialDateTime != null) {
      initialDateTime = widget.initialDateTime!;
    } else {
      initialDateTime = maximumDate;
    }
    _currMonth = initialDateTime.month;
    _currYear = initialDateTime.year;
    _currDay = initialDateTime.day;
    _calcDayRange(currMonth: _currMonth);
    _calcMonthRange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 188.h,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: backgroundColor),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: ListWheelScrollView.useDelegate(
                          physics: FixedExtentScrollPhysics(),
                          diameterRatio: pi / 3,
                          onSelectedItemChanged: (item) {
                            setState(() {
                              _currDay = item + 1;
                            });
                            widget.onSelectedItemChanged.call(
                                DateTime(_currYear, _currMonth, _currDay));
                          },
                          controller: FixedExtentScrollController(
                              initialItem: initialDateTime.day - 1),
                          itemExtent: 44.h,
                          childDelegate: ListWheelChildBuilderDelegate(
                              childCount: _calcDayRange().last -
                                  _calcDayRange().first +
                                  1,
                              builder: (context, index) {
                                return SizedBox(
                                  height: 44.h,
                                  child: Center(
                                      child: Text(
                                          (_calcDayRange().first + index) < 10
                                              ? '0' +
                                                  (_calcDayRange().first +
                                                          index)
                                                      .toString()
                                              : (_calcDayRange().first + index)
                                                  .toString(),
                                          style: _currDay == index + 1
                                              ? text18.bold
                                                  .copyWith(color: Colors.white)
                                              : text18.copyWith(
                                                  color: backgroundColor))),
                                );
                              }))),
                  Expanded(
                      child: ListWheelScrollView.useDelegate(
                          physics: FixedExtentScrollPhysics(),
                          diameterRatio: pi / 3,
                          onSelectedItemChanged: (item) {
                            setState(() {
                              _currMonth = item + 1;
                              _calcDayRange(currMonth: _currMonth);
                              modifiedCurrentDay();
                            });
                            widget.onSelectedItemChanged.call(
                                DateTime(_currYear, _currMonth, _currDay));
                          },
                          controller: FixedExtentScrollController(
                              initialItem: initialDateTime.month - 1),
                          itemExtent: 44.h,
                          childDelegate: ListWheelChildBuilderDelegate(
                              childCount: _calcMonthRange().last -
                                  _calcMonthRange().first +
                                  1,
                              builder: (context, index) {
                                return SizedBox(
                                  height: 44.h,
                                  child: Center(
                                      child: Text(vietnameseMonthList[index],
                                          style: _currMonth == index + 1
                                              ? text18.bold
                                                  .copyWith(color: Colors.white)
                                              : text18.copyWith(
                                                  color: backgroundColor))),
                                );
                              }))),
                  Expanded(
                      child: ListWheelScrollView.useDelegate(
                          physics: FixedExtentScrollPhysics(),
                          diameterRatio: pi / 3,
                          onSelectedItemChanged: (item) {
                            setState(() {
                              _currYear = minimumDate.year + item;
                              _calcDayRange(currMonth: _currMonth);
                            });
                            widget.onSelectedItemChanged.call(
                                DateTime(_currYear, _currMonth, _currDay));
                          },
                          controller: FixedExtentScrollController(
                              initialItem:
                                  initialDateTime.year - minimumDate.year),
                          itemExtent: 44.h,
                          childDelegate: ListWheelChildBuilderDelegate(
                              childCount: _calcYearRange().last -
                                  _calcYearRange().first +
                                  1,
                              builder: (context, index) {
                                return SizedBox(
                                  height: 44.h,
                                  child: Center(
                                      child: Text(
                                    (minimumDate.year + index).toString(),
                                    style: _currYear == minimumDate.year + index
                                        ? text18.bold
                                            .copyWith(color: Colors.white)
                                        : text18.copyWith(
                                            color: backgroundColor),
                                  )),
                                );
                              }))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<int> _calcYearRange() {
    return [minimumDate.year, maximumDate.year];
  }

  /// calculate the range of month
  List<int> _calcMonthRange() {
    int minMonth = 1, maxMonth = 12;
    int minYear = minimumDate.year;
    int maxYear = maximumDate.year;
    // if (minYear == _currYear) {
    //   // selected minimum year, limit month range
    //   minMonth = minimumDate.month;
    // }
    // if (maxYear == _currYear) {
    //   // selected maximum year, limit month range
    //   maxMonth = maximumDate.month;
    // }
    return [minMonth, maxMonth];
  }

  List<int> _calcDayRange({currMonth}) {
    int minDay = 1, maxDay = _calcDayCountOfMonth();
    int minYear = minimumDate.year;
    int maxYear = maximumDate.year;
    int minMonth = minimumDate.month;
    int maxMonth = maximumDate.month;
    currMonth ??= _currMonth;
    // if (minYear == _currYear && minMonth == currMonth) {
    //   // selected minimum year and month, limit day range
    //   minDay = minimumDate.day;
    // }
    // if (maxYear == _currYear && maxMonth == currMonth) {
    //   // selected maximum year and month, limit day range
    //   maxDay = maximumDate.day;
    // }
    return [minDay, maxDay];
  }

  int _calcDayCountOfMonth() {
    if (_currMonth == 2) {
      return isLeapYear(_currYear) ? 29 : 28;
    } else if (solarMonthsOf31Days.contains(_currMonth)) {
      return 31;
    }
    return 30;
  }

  /// whether or not is leap year
  bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  void modifiedCurrentDay() {
    int lastDay = _calcDayRange().last;
    if (_currDay > lastDay) {
      _currDay = lastDay;
    }
  }
}
