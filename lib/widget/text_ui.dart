import 'package:flutter/material.dart';

class TextUI extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final double? height;
  final double? letterSpacing;

  const TextUI(this.text,
      {super.key,
      this.fontSize = 20,
      this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      this.textAlign,
      this.height,
      this.letterSpacing});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            height: height,
            letterSpacing: letterSpacing),
        textAlign: textAlign);
  }
}
