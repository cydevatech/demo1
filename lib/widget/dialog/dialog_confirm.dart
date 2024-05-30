import 'package:demo1/widget/button/button_primary.dart';
import 'package:demo1/assets/index.dart';
import 'package:demo1/widget/button/outline_button.dart';
import 'package:flutter/material.dart';

// DEMO
// DialogConfirm.show(
//     context,
//     title: 'Đăng xuất',
//     body: 'Bạn có chắc chắn đăng xuất',
//     txtAccept: 'Chấp nhận',
//     titleSize: 24.sp,
//     bodySize: 18.sp,
//     onAccept: () {
//       Navigator.pop(context);
//     },
//     txtCancel: 'Hủy',
//   );

class DialogConfirm extends StatefulWidget {
  final String? title;
  final double? titleSize;
  final double? horizontal;
  final double? iconSize;
  final String? body;
  final double? bodySize;
  final double? textSize;
  final String? txtCancel;
  final Function? onCancel;
  final String? txtAccept;
  final Function? onAccept;
  final String? icon;
  const DialogConfirm({
    super.key,
    this.title,
    this.titleSize,
    this.horizontal,
    this.iconSize,
    this.body,
    this.bodySize,
    this.textSize,
    this.txtCancel,
    this.onCancel,
    this.txtAccept,
    this.onAccept,
    this.icon,
  });

  @override
  State<DialogConfirm> createState() => _DialogConfirmState();
  static Future show(
    BuildContext context, {
    String? title,
    double? titleSize,
    double? horizontal,
    double? iconSize,
    String? body,
    double? bodySize,
    double? textSize,
    String? txtCancel,
    Function? onCancel,
    String? txtAccept,
    Function? onAccept,
    String? icon,
    bool? barrierDismissible,
  }) async {
    await showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? true,
        builder: (context) {
          return WillPopScope(
              child: DialogConfirm(
                title: title,
                titleSize: titleSize,
                horizontal: horizontal,
                iconSize: iconSize,
                body: body,
                bodySize: bodySize,
                txtCancel: txtCancel,
                onCancel: onCancel,
                txtAccept: txtAccept,
                onAccept: onAccept,
                textSize: textSize,
                icon: icon,
              ),
              onWillPop: () => Future.value(barrierDismissible ?? true));
        });
  }
}

class _DialogConfirmState extends State<DialogConfirm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontal ?? 20.sp),
      alignment: Alignment.center,
      child: Material(
        color: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sp),
        ),
        type: MaterialType.card,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.sp, 12.sp, 20.sp, 30.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.icon != null
                  ? ImageAssets.svgAssets(
                      '${widget.icon}',
                      width: widget.iconSize ?? 60.sp,
                    )
                  : const SizedBox(),
              SizedBox(
                height: 10.sp,
              ),
              widget.title != null
                  ? Text(
                      '${widget.title}',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: widget.titleSize ?? 22.sp,
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const SizedBox(),
              widget.body != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          '${widget.body}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: widget.bodySize ?? 16.sp,
                            color: kcBackground,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: 30.sp,
              ),
              Row(
                mainAxisAlignment:
                    widget.txtCancel == null || widget.txtAccept == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                children: [
                  widget.txtCancel != null
                      ? SizedBox(
                          width: 140.sp,
                          height: 40.sp,
                          child: ButtonOutline(
                            onPress: () {
                              Navigator.pop(context);
                            },
                            text: '${widget.txtCancel}',
                            textSize: widget.textSize ?? 14.sp,
                            color: Color(0xffEEEEEE),
                            borderWidth: 0,
                            borderWidthColor: Color(0xffEEEEE3),
                          ),
                        )
                      : const SizedBox(),
                  widget.txtAccept != null
                      ? SizedBox(
                          width: 140.sp,
                          height: 40.sp,
                          child: ButtonPrimary(
                            onPress: widget.onAccept!,
                            text: '${widget.txtAccept}',
                            textSize: widget.textSize ?? 14.sp,
                            // color: Color(0xffDD3131),
                            colorText: Colors.white,
                          ),
                        )
                      : const SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
