import 'package:flutter/material.dart';
import 'package:demo1/widget/touchable_opacity.dart';

import '../../assets/index.dart';

class ButtonDisable extends StatefulWidget {
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

  const ButtonDisable(
      {super.key,
      required this.onPress,
      this.disabled = false,
      this.text = 'Tiếp tục',
      this.textSize = 14,
      this.paddingHorizontal = 12.0,
      this.paddingVertical = 0.0,
      this.color,
      this.colorText = dLabelColor,
      this.fontWeight = FontWeight.bold,
      this.borderRadius = 120.0,
      this.borderWidth = 0,
      this.borderWidthColor = dLabelColor});

  @override
  State<ButtonDisable> createState() => _ButtonDisableState();
}

class _ButtonDisableState extends State<ButtonDisable> {
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
        widget.onPress();
      },
      child: Container(
        width: double.infinity,
        height: 44.sp,
        padding: EdgeInsets.symmetric(
            vertical: widget.paddingVertical.sp,
            horizontal: widget.paddingHorizontal.sp),
        decoration: BoxDecoration(
          color: const Color(0xffEEEEEE),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: widget.textSize.sp,
              color: widget.colorText,
              fontWeight: widget.fontWeight),
        ),
      ),
    );
  }
}
