import 'package:demo1/assets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IncomeTextFiled extends StatefulWidget {
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final String? prefixIcon;
  final String? suffixIcon;
  final ValueNotifier<bool>? validNotifier;
  final bool isEnable;
  const IncomeTextFiled({
    super.key,
    this.focusNode,
    this.nextFocusNode,
    this.labelText,
    this.controller,
    this.validator,
    this.validNotifier,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.suffixIcon,
    this.isEnable = true,
  });

  @override
  State<IncomeTextFiled> createState() => _IncomeTextFiledState();
}

class _IncomeTextFiledState extends State<IncomeTextFiled> {
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      if (widget.validator != null) {
        setState(() {
          isValid =
              !(widget.validator!(widget.controller?.text)?.isNotEmpty == true);
          if (widget.validNotifier != null) {
            widget.validNotifier?.value = isValid;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (val) {},
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: (v) {
        widget.focusNode?.unfocus();
        widget.nextFocusNode?.requestFocus();
      },
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        // CurrencyTextInputFormatter(decimalDigits: 0, symbol: '\$')
      ],
      enabled: widget.isEnable,
      decoration: InputDecoration(
        hintText: widget.labelText,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: widget.suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SvgPicture.asset(widget.suffixIcon!,
                    color: widget.isEnable
                        ? blueColor
                        : blueColor.withOpacity(0.4)),
              )
            : null,
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12),
                child: SvgPicture.asset(widget.prefixIcon!,
                    color: widget.isEnable
                        ? blueColor
                        : blueColor.withOpacity(0.4)),
              )
            : null,
        hintStyle: const TextStyle(fontSize: 15),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: blueColor, width: 1)),
        contentPadding: const EdgeInsets.only(top: 12, bottom: 12, left: 24),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: backgroundColor, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: blueColor, width: 1)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(color: blueColor.withOpacity(0.4), width: 1)),
      ),
    );
  }
}
