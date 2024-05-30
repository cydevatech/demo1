import 'package:flutter/material.dart';
import 'package:demo1/assets/colors.dart';

// ignore: must_be_immutable
class CustomCheckboxButton extends StatelessWidget {
  CustomCheckboxButton({
    super.key,
    required this.onChange,
    this.iconSize,
    this.value,
    this.textWidget,
    this.width,
    this.margin,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.isExpandedText = false,
  });

  final double? iconSize;
  bool? value;
  final Function(bool) onChange;
  final Widget? textWidget;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextAlign? textAlignment;
  final bool isExpandedText;

  @override
  Widget build(BuildContext context) {
    return buildCheckBoxWidget(context);
  }

  Widget buildCheckBoxWidget(context) {
    return InkWell(
      onTap: () {
        value = !(value!);
        onChange(value!);
      },
      child: Container(
        width: width,
        margin: margin ?? EdgeInsets.zero,
        child: leftSideCheckbox(context),
      ),
    );
  }

  Widget leftSideCheckbox(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: checkboxWidget(context),
        ),
        textWidget != null ? Expanded(child: textWidget!) : const SizedBox(),
      ],
    );
  }

  Widget checkboxWidget(BuildContext context) {
    return SizedBox(
      height: iconSize ?? 24,
      width: iconSize ?? 24,
      child: Checkbox(
        side: const BorderSide(
          color: primaryColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        checkColor: primaryColor,
        activeColor: Colors.white,
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
        value: value ?? false,
        onChanged: (value) {
          onChange(value!);
        },
      ),
    );
  }
}
