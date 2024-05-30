import 'package:demo1/widget/button/button_primary.dart';
import 'package:demo1/assets/index.dart';
import 'package:demo1/widget/button/outline_button.dart';
import 'package:flutter/material.dart';

// DEMO
// DialogDelete.show(
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

class DialogDelete extends StatefulWidget {
  final String? title;
  final double? titleSize;
  final double? horizontal;
  final double? iconSize;
  final String? body;
  final double? bodySize;
  final String? subBody;
  final double? subBodySize;
  final String? txtCancel;
  final Function? onCancel;
  final String? txtAccept;
  final Function? onAccept;
  final String? icon;
  const DialogDelete({
    super.key,
    this.title,
    this.titleSize,
    this.horizontal,
    this.iconSize,
    this.body,
    this.subBody,
    this.subBodySize,
    this.bodySize,
    this.txtCancel,
    this.onCancel,
    this.txtAccept,
    this.onAccept,
    this.icon,
  });

  @override
  State<DialogDelete> createState() => _DialogDeleteState();
  static Future show(
    BuildContext context, {
    String? title,
    double? titleSize,
    double? horizontal,
    double? iconSize,
    String? body,
    double? bodySize,
    String? subBody,
    double? subBodySize,
    String? txtCancel,
    Function? onCancel,
    String? txtAccept,
    Function? onAccept,
    String? icon,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              child: DialogDelete(
                title: title,
                titleSize: titleSize,
                horizontal: horizontal,
                iconSize: iconSize,
                body: body,
                bodySize: bodySize,
                subBody: subBody,
                subBodySize: subBodySize,
                txtCancel: txtCancel,
                onCancel: onCancel,
                txtAccept: txtAccept,
                onAccept: onAccept,
                icon: icon,
              ),
              onWillPop: () => Future.value(true));
        });
  }
}

class _DialogDeleteState extends State<DialogDelete> {
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
          padding: EdgeInsets.fromLTRB(20.sp, 20.sp, 20.sp, 30.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.icon != null
                  ? ImageAssets.svgAssets(
                      '${widget.icon}',
                      width: widget.iconSize ?? 25.sp,
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
                        fontSize: widget.titleSize ?? 24.sp,
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
                            fontSize: widget.bodySize ?? 18.sp,
                            color: kcBackground,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              widget.subBody != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          '${widget.subBody}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: widget.subBodySize ?? 14.sp,
                            color: kcBackground,
                            fontWeight: FontWeight.w500,
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
                            textSize: 12.sp,
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
                            textSize: 12.sp,
                            color: Color(0xffDD3131),
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
