import 'package:demo1/assets/index.dart';
import 'package:demo1/widget/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:get/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double? sizeWidth = 0;
  @override
  Widget build(BuildContext context) {
    print('GetPlatform.isMobile ${sizer.width} ');
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        print('constraints.maxWidth  ${constraints.maxWidth}');
        sizeWidth = constraints.maxWidth;
        if (constraints.maxWidth > Constants.maxDevice) {
          return _screen();
        } else {
          return _screen();
        }
      }),
    );
  }

  Widget _screen() {
    return SafeArea(
      child: Stack(
        children: [
          Center(
            child: Container(
              constraints:
                  (GetPlatform.isWeb && (sizeWidth ?? 0) > Constants.maxDevice)
                      ? BoxConstraints(
                          maxWidth: SizeHelper.mainSizeWidth() + 10,
                          maxHeight: SizeHelper.mainSizeHeight(),
                        )
                      : BoxConstraints(),
              width: double.infinity,
              height:
                  (GetPlatform.isWeb && (sizeWidth ?? 0) > Constants.maxDevice)
                      ? 640
                      : sizer.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((GetPlatform.isWeb &&
                        (sizeWidth ?? 0) > Constants.maxDevice)
                    ? 30
                    : 0),
                color: primaryColor,
              ),
              child: body(),
            ),
          ),
          if (GetPlatform.isWeb && (sizeWidth ?? 0) > Constants.maxDevice)
            IgnorePointer(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/iphone.png",
                  width: 340,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(width: 20.sp),
              Text(
                'Đăng nhập',
                style: text16.medium.black,
              ),
            ],
          ),
        )
      ],
    );
  }
}
