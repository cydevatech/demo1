import 'package:demo1/assets/index.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key, this.isTransparent = true, this.size = 50})
      : super(key: key);
  final bool isTransparent;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color:
            isTransparent ? Colors.transparent : Colors.white60.withOpacity(.6),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: ImageAssets.pngAsset(
            CommonGif.loading,
            width: size,
          ),
        ),
      ),
    );
  }
}
