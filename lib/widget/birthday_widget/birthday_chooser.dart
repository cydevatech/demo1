import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:demo1/assets/index.dart';
import 'package:demo1/utils/string.dart';
import 'package:demo1/widget/birthday_widget/birthday_picker.dart';
import 'package:demo1/widget/button/button_primary.dart';
import 'package:demo1/widget/ripple.dart';

// DEMO
//  BirthdayChooser(
//    abel: 'Ngày tháng năm sinh',
//    prefixIcon: ImageAssets.svgAssets(
//    Svg.icAbout,
//     ),
//     selectedValue: null,
//     onSelectedItemChanged: (value) {
//     setState(() {
//     print('xxxx ${value}');
//    });
//    },
//     enable: true,
//  ),
class BirthdayChooser extends StatefulWidget {
  const BirthdayChooser({
    Key? key,
    required this.label,
    required this.onSelectedItemChanged,
    this.selectedValue,
    this.maximumDate,
    this.minimumDate,
    this.initialDateTime,
    this.hasValidate = false,
    this.buttonTitle,
    this.enable = true,
    this.prefixIcon,
    this.validator,
  }) : super(key: key);
  final String label;
  final DateTime? selectedValue;
  final Function(DateTime) onSelectedItemChanged;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final DateTime? initialDateTime;
  final bool hasValidate;
  final String? buttonTitle;
  final bool enable;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  @override
  State<BirthdayChooser> createState() => BirthdayChooserState();
}

class BirthdayChooserState extends State<BirthdayChooser> {
  Color? _errorBorder;
  final _dateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.selectedValue != null) {
      _dateController.text = DateFormat('dd/MM/yyyy')
          .format(widget.selectedValue ?? DateTime.now());
    }
  }

  @override
  void didUpdateWidget(BirthdayChooser oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != null) onValidate();
  }

  String? defaultValidator(value) {
    if (value?.isEmpty ?? true) {
      return 'Vui lòng chọn ngày tháng năm';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Ripple(
      padding: const EdgeInsets.only(
        top: 4,
      ),
      onTap: !widget.enable
          ? null
          : () {
              FocusManager.instance.primaryFocus?.unfocus();
              showModalBottomSheet(
                  barrierColor: blackColor.withOpacity(.8),
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: whiteColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(28))),
                  builder: (context) {
                    DateTime? currentBirthday =
                        widget.selectedValue ?? widget.initialDateTime;
                    bool validate =
                        currentBirthday != null && widget.hasValidate
                            ? validateDate(date: currentBirthday.formatDMY)
                            : true;

                    return StatefulBuilder(builder: (context, setState2) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 24,
                                ),
                                Text(
                                  widget.label,
                                  style:
                                      text18.bold.copyWith(color: Colors.black),
                                ),
                                Ripple(
                                    onTap: Navigator.of(context).pop,
                                    child: ImageAssets.svgAssets(
                                      Svg.icCancel,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 1.h,
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: BirthdayPicker(
                                initialDateTime: currentBirthday,
                                maximumDate: widget.maximumDate,
                                minimumDate: widget.minimumDate,
                                onSelectedItemChanged: (value) {
                                  setState2(() {
                                    currentBirthday = value;
                                    if (widget.hasValidate) {
                                      validate =
                                          validateDate(date: value.formatDMY);
                                    }
                                  });
                                },
                              )),
                          SizedBox(
                            height: 24.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: ButtonPrimary(
                              onPress: () {
                                widget.onSelectedItemChanged.call(
                                    currentBirthday ??
                                        DateTime(DateTime.now().year - 18));
                                if (currentBirthday != null) {
                                  _dateController.text =
                                      DateFormat('dd/MM/yyyy')
                                          .format(currentBirthday!);
                                }
                                Navigator.of(context).pop();
                              },
                              text: 'Cập nhật',
                              colorText: whiteColor,
                              textSize: 16,
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).viewPadding.bottom + 8.h,
                          )
                        ],
                      );
                    });
                  });
            },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120.r),
          border: Border.all(
            color: _errorBorder ?? grey400,
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _dateController.text == ''
                    ? 'Chọn ngày sinh'
                    : _dateController.text,
                style: text14.medium.copyWith(
                  color: const Color(0xff888888),
                ),
              ),
              widget.prefixIcon ??
                  Icon(Icons.calendar_today_outlined,
                      color: const Color(0xff888888), size: 20.w),
            ],
          ),
        ),
      ),
    );
  }

  void onValidate() {
    if (widget.selectedValue != null) {
      setState(() {
        _errorBorder = null;
      });
    } else {
      setState(() {
        _errorBorder = Colors.red;
      });
    }
  }
}
