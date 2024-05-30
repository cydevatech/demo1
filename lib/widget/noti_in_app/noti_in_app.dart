import 'package:flutter/material.dart';
import 'package:demo1/assets/index.dart';
import 'package:demo1/widget/noti_in_app/flash.dart';

const Duration _dialogDisplayDuration = Duration(seconds: 3);
GlobalKey _flushBarKey = GlobalKey();
bool isShow = false;

class InAppNoti extends StatefulWidget {
  final Duration? duration;
  final bool largePadding;
  final Function? onClose;
  final bool autoClose;
  final String? challengeName;
  final int? challengePoint;
  final String? avt;
  final Function? onPress;
  final String? title;
  final TextStyle? titleStyle;
  final String? content;
  final TextStyle? contentStyle;
  final String? icon;
  final PopupStyles? popupStyle;
  const InAppNoti({
    Key? key,
    this.content,
    this.contentStyle,
    this.duration = const Duration(seconds: 3),
    this.onClose,
    this.largePadding = false,
    this.autoClose = true,
    this.challengeName,
    this.challengePoint,
    this.avt,
    this.onPress,
    this.title,
    this.titleStyle,
    this.icon,
    this.popupStyle = PopupStyles.noti,
  }) : super(key: key);

  @override
  State<InAppNoti> createState() => _FowiDialogState();

  static void close(BuildContext context) {
    if (isShow) {
      if (_flushBarKey.currentWidget != null &&
          _flushBarKey.currentWidget is Flash) {
        (_flushBarKey.currentWidget as Flash).controller.dismiss();
        isShow = false;
      }
    }
  }

  static Future show(
    BuildContext context, {
    required String content,
    Function? onClose,
    bool barrierDismissible = true,
    Duration duration = _dialogDisplayDuration,
    bool largePadding = true,
    String? avt,
    Function? onPress,
    String? title,
    String? icon,
    PopupStyles? popupStyle,
  }) async {
    if (isShow) return;
    _flushBarKey = GlobalKey();
    isShow = true;
    await showFlash(
      context: context,
      transitionDuration: const Duration(milliseconds: 5),
      builder: (_, controller) {
        return Flash(
          key: _flushBarKey,
          controller: controller,
          brightness: Brightness.light,
          behavior: FlashBehavior.floating,
          enableVerticalDrag: false,
          position: FlashPosition.top,
          forwardAnimationCurve: Curves.ease,
          reverseAnimationCurve: Curves.ease,
          backgroundColor: Colors.transparent,
          insetAnimationDuration: const Duration(seconds: 5),
          barrierDismissible: true,
          child: InAppNoti(
            content: content,
            onClose: () => close(context),
            duration: duration,
            largePadding: largePadding,
            avt: avt,
            onPress: onPress,
            title: title,
            icon: icon,
            popupStyle: popupStyle,
          ),
        );
      },
    );
  }
}

class _FowiDialogState extends State<InAppNoti> {
  EdgeInsetsGeometry dialogPadding = const EdgeInsets.all(12.0);

  @override
  void initState() {
    super.initState();
    dialogPadding = widget.largePadding
        ? EdgeInsets.symmetric(horizontal: 16.sp, vertical: 11.sp)
        : EdgeInsets.all(12.r);
    if (widget.autoClose && widget.duration != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          Future.delayed(widget.duration!).then(
            (value) {
              widget.onClose?.call();
            },
          );
        },
      );
    }
  }

  @override
  void deactivate() {
    widget.onClose?.call();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.1),
            blurRadius: 4.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      // color: Colors.amber,
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title ?? '',
                style: widget.titleStyle ?? text16.primary.bold),
            SizedBox(height: 8.h),
            Text(
              widget.content ?? '',
              style: widget.contentStyle ?? text14.black,
            ),
          ],
        ),
      ),
    );
  }
}

enum PopupStyles {
  noti,
  active,
}
