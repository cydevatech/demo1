import 'package:flutter/material.dart';

import '../../assets/index.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool value;
  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          value = !value;
          widget.onChanged.call(value);
        });
        // widget.value == false ? widget.onChanged(true) : widget.onChanged(false);
      },
      child: AnimatedContainer(
        width: 44.sp,
        height: 24.sp,
        decoration: BoxDecoration(
          color: value ? backgroundColor : grey400,
          borderRadius: BorderRadius.circular(24.0.sp),
          border:
              Border.all(color: value ? backgroundColor : grey400, width: 1),
        ),
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: EdgeInsets.all(0.sp),
          child: AnimatedContainer(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0.sp),
              color: value ? backgroundColor : grey400,
            ),
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 24.sp,
              height: 24.sp,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
