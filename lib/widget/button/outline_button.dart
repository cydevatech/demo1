import 'package:flutter/material.dart';
import 'package:demo1/widget/touchable_opacity.dart';

import '../../assets/index.dart';

class ButtonOutline extends StatefulWidget {
  final Function onPress;
  final bool disabled;
  final String text;
  final double textSize;
  final double paddingHorizontal;
  final double paddingVertical;
  final Color? color;
  final Color colorText;
  final double borderRadius;
  final FontWeight fontWeight;
  final double borderWidth;
  final Color borderWidthColor;

  const ButtonOutline(
      {super.key,
      required this.onPress,
      this.disabled = false,
      this.text = 'Tiếp tục',
      this.textSize = 14,
      this.paddingHorizontal = 12.0,
      this.paddingVertical = 0.0,
      this.color,
      this.colorText = backgroundColor,
      this.fontWeight = FontWeight.bold,
      this.borderRadius = 10,
      this.borderWidth = 1,
      this.borderWidthColor = backgroundColor});

  @override
  State<ButtonOutline> createState() => _ButtonOutlineState();
}

class _ButtonOutlineState extends State<ButtonOutline> {
  Color? renderButtonColor() {
    if (widget.disabled) return const Color(0xff828282);
    if (widget.color != null) return widget.color;
    return null;
  }

  late double textSize;
  @override
  void initState() {
    super.initState();
    textSize = widget.textSize.sp;
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {
        if (!widget.disabled) {
          widget.onPress();
        }
      },
      child: Container(
        width: double.infinity,
        height: 44.sp,
        padding: EdgeInsets.symmetric(
            vertical: widget.paddingVertical.sp,
            horizontal: widget.paddingHorizontal.sp),
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
              width: widget.borderWidth,
              color: !widget.disabled ? widget.borderWidthColor : dLabelColor),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: widget.textSize.sp,
              color: !widget.disabled ? widget.colorText : dLabelColor,
              fontWeight: widget.fontWeight),
        ),
      ),
    );
  }
}
