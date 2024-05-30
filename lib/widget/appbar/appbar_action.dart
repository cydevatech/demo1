import 'package:flutter/material.dart';
import 'package:demo1/utils/string.dart';
import 'package:demo1/widget/touchable_opacity.dart';

import '../../assets/index.dart';

class AppBarAction extends StatelessWidget {
  final Function? actionLeft;
  final Function? actionRight;
  final String? icLeft;
  final String? icRight;
  final String title;
  final double? sizeLeft;
  final double? sizeRight;

  const AppBarAction({
    super.key,
    this.actionLeft,
    this.actionRight,
    required this.title,
    this.icLeft,
    this.icRight,
    this.sizeLeft,
    this.sizeRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: inputColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icLeft.isNullOrEmpty
              ? SizedBox(
                  width: 24.sp,
                )
              : TouchableOpacity(
                  onTap: actionLeft,
                  child: ImageAssets.svgAssets(
                    icLeft ?? '',
                    width: sizeLeft ?? 24.sp,
                    fit: BoxFit.cover,
                  ),
                ),
          Text(
            title,
            style: text18.black.bold,
          ),
          icRight.isNullOrEmpty
              ? SizedBox(
                  width: 24.sp,
                )
              : TouchableOpacity(
                  onTap: actionRight,
                  child: ImageAssets.svgAssets(
                    icRight ?? '',
                    width: sizeRight ?? 24.sp,
                    fit: BoxFit.cover,
                  ),
                ),
        ],
      ),
    );
  }
}
