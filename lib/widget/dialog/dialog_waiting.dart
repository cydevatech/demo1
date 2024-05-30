import 'package:flutter/material.dart';
import 'package:demo1/assets/index.dart';

class DialogWaiting extends StatelessWidget {
  static bool isShow = false;
  final String? title;
  const DialogWaiting({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: <Widget>[
          const CircularProgressIndicator(
            color: primaryColor,
          ),
          const SizedBox(width: 20),
          Text(title ?? "Đang tải xin chờ..."),
        ],
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    String? title,
  }) async {
    if (isShow) {
      return;
    }
    isShow = true;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DialogWaiting(title: title),
    );
  }

  static Future<void> hide(BuildContext context) async {
    if (!isShow) {
      return;
    }
    isShow = false;
    Navigator.of(context).pop();
  }
}
