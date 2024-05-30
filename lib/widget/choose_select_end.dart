import 'package:demo1/assets/index.dart';
import 'package:demo1/widget/ripple.dart';
import 'package:demo1/widget/touchable_opacity.dart';
import 'package:flutter/material.dart';

class ChooseSelectEnd extends StatefulWidget {
  const ChooseSelectEnd({
    Key? key,
    this.data,
    this.selectedValues = const [],
    this.buttonTitle,
    this.onTap,
    this.autoBack = true,
  }) : super(key: key);
  final List<String>? data;
  final List<String>? selectedValues;
  final String? buttonTitle;
  final Function()? onTap;
  final bool autoBack;

  static Future<List?> show(
    BuildContext context, {
    List<String>? data,
    List<String> initSelected = const [],
    String? title,
    String? buttonTitle,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    var result = await showModalBottomSheet<List?>(
      context: context,
      barrierColor: backgroundColor.withOpacity(0.8),
      backgroundColor: backgroundColor,
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 117.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 24,
                  ),
                  Text(
                    '$title',
                    style: text20.bold.copyWith(color: Colors.white),
                  ),
                  Ripple(
                      radius: 48.r,
                      onTap: Navigator.of(context).pop,
                      child: ImageAssets.svgAssets(Svg.icCancel))
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              color: backgroundColor,
              height: 1.h,
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ChooseSelectEnd(
                data: data,
                selectedValues: initSelected,
                buttonTitle: buttonTitle,
                autoBack: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).viewPadding.bottom + 8.h,
            )
          ],
        );
      },
    );
    return result;
  }

  @override
  State<ChooseSelectEnd> createState() => _ChooseSelectEndState();
}

class _ChooseSelectEndState extends State<ChooseSelectEnd> {
  final List selectedRelationships = [];
  @override
  void initState() {
    selectedRelationships.addAll(widget.selectedValues as Iterable);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var e in widget.data ?? [])
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
            margin: EdgeInsets.only(bottom: 10.sp),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: grey50)),
            child: Column(
              children: [
                TouchableOpacity(
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 300.sp,
                          child: Text(
                            e,
                            style: text12.black,
                          ),
                        ),
                        ImageAssets.svgAssets(
                          selectedRelationships.contains(e)
                              ? Svg.icRadio
                              : Svg.icUnRadio,
                          width: 20.sp,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      setSelectedRelationships(e);
                    });
                  },
                ),
              ],
            ),
          ),

        // FowButton.fullSize(
        //   child: Text(widget.buttonTitle),
        //   onPressed: selectedRelationships.isEmpty
        //       ? null
        //       : () {
        //           widget.onTap?.call(selectedRelationships);
        //           if (widget.autoBack) Navigator.of(context).pop();
        //         },
        // ),
      ],
    );
  }

  void setSelectedRelationships(value) {
    if (selectedRelationships.contains(value)) {
      selectedRelationships.remove(value);
      return;
    }
    selectedRelationships.add(value);
  }
}
