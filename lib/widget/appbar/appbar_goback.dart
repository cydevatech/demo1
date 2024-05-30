import 'package:flutter/material.dart';

import '../../assets/index.dart';

class AppBarGoBack extends StatelessWidget {
  final String? title;
  final Widget? trailing;
  final bool? centerTitle;
  final Function()? onPress;

  const AppBarGoBack(
      {super.key,
      this.title,
      this.trailing,
      this.centerTitle = false,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: whiteColor,
      elevation: 0,
      shadowColor: Colors.amber,
      leading: IconButton(
        onPressed: onPress ??
            () {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xff000000),
        ),
      ),
      title: Text(
        title ?? '',
        style: text22.medium.black,
      ),
      centerTitle: centerTitle,
      actions: [
        trailing ?? const SizedBox(),
        SizedBox(width: 16.w),
      ],
    );
  }
}
