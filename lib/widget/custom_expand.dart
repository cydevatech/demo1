import 'package:flutter/material.dart';
import 'package:demo1/assets/index.dart';

// ignore: must_be_immutable
class CustomExpansionTile extends StatefulWidget {
  final Widget child;
  final Widget onExpansion;
  bool isExpanded;
  final Function? onTap;

  CustomExpansionTile({
    Key? key,
    required this.child,
    required this.onExpansion,
    this.isExpanded = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
              setState(() {
                widget.isExpanded = !widget.isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.child,
                      ],
                    ),
                  ),
                  SizedBox(width: 12.sp),
                  RotationTransition(
                    turns: widget.isExpanded
                        ? const AlwaysStoppedAnimation(0)
                        : const AlwaysStoppedAnimation(0.5),
                    child: ImageAssets.svgAssets(
                      Svg.icDown,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.isExpanded ? widget.onExpansion : const SizedBox(),
        ],
      ),
    );
  }
}
