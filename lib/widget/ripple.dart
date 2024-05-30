import 'package:demo1/assets/index.dart';
import 'package:flutter/material.dart';

class Ripple extends StatelessWidget {
  final Widget? child;

  final GestureTapCallback? onTap;
  final EdgeInsets padding;
  final double? radius;
  final double? width;
  final double? height;
  final bool disable;
  final bool hasRadiusTop;
  final bool hasRadiusBottom;
  final Color? highlightColor;
  const Ripple({
    Key? key,
    this.child,
    this.onTap,
    this.padding = EdgeInsets.zero,
    this.radius,
    this.width,
    this.height,
    this.disable = false,
    this.hasRadiusTop = true,
    this.hasRadiusBottom = true,
    this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: hasRadiusTop ? Radius.circular(radius ?? 8.w) : Radius.zero,
        topRight: hasRadiusTop ? Radius.circular(radius ?? 8.w) : Radius.zero,
        bottomLeft:
            hasRadiusBottom ? Radius.circular(radius ?? 8.w) : Radius.zero,
        bottomRight:
            hasRadiusBottom ? Radius.circular(radius ?? 8.w) : Radius.zero,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: width,
            height: height,
            padding: padding,
            child: child,
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: !disable ? onTap : null,
                splashColor: !disable
                    ? highlightColor ?? blackColor.withOpacity(0.1)
                    : null,
                highlightColor: !disable
                    ? highlightColor ?? blackColor.withOpacity(0.1)
                    : null,
                child: const SizedBox.expand(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
