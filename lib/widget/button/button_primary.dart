import 'package:flutter/material.dart';
import 'package:demo1/widget/touchable_opacity.dart';

import '../../assets/index.dart';

class ButtonPrimary extends StatefulWidget {
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
  final double? height;
  final double? width;

  const ButtonPrimary(
      {super.key,
      required this.onPress,
      this.disabled = false,
      this.text = 'Tiếp tục',
      this.textSize = 14,
      this.paddingHorizontal = 12.0,
      this.paddingVertical = 0.0,
      this.color,
      this.colorText = Colors.black,
      this.fontWeight = FontWeight.bold,
      this.borderRadius = 10.0,
      this.borderWidth = 0,
      this.height = 44,
      this.width = double.infinity,
      this.borderWidthColor = Colors.transparent});

  @override
  State<ButtonPrimary> createState() => _ButtonPrimaryState();
}

class _ButtonPrimaryState extends State<ButtonPrimary> {
  Color? renderButtonColor() {
    if (widget.disabled) return const Color(0xff828282);
    if (widget.color != null) return backgroundColor;
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
        width: widget.width,
        height: widget.height?.sp,
        padding: EdgeInsets.symmetric(
            vertical: widget.paddingVertical.sp,
            horizontal: widget.paddingHorizontal.sp),
        decoration: BoxDecoration(
            border: Border.all(
                width: widget.borderWidth, color: widget.borderWidthColor),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: !widget.disabled
                ? widget.color ?? primaryColor
                : const Color(0xffD2D2D2)),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: widget.textSize.sp,
              color:
                  !widget.disabled ? widget.colorText : const Color(0xff9D8F8F),
              fontWeight: widget.fontWeight),
        ),
      ),
    );
  }
}
