import 'package:demo1/widget/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:demo1/assets/colors.dart';
import 'package:demo1/assets/index.dart';
import 'package:demo1/widget/button/button_primary.dart';
import 'package:demo1/widget/input/app_input.dart';

class ReasonCancelBottomSheet extends StatefulWidget {
  const ReasonCancelBottomSheet({super.key});
  @override
  State<ReasonCancelBottomSheet> createState() =>
      _ReasonCancelBottomSheetState();

  static Future<CancelReason?> show({
    required BuildContext context,
  }) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const ReasonCancelBottomSheet(),
    );

    return result;
  }
}

class _ReasonCancelBottomSheetState extends State<ReasonCancelBottomSheet> {
  final List<String> reasons = [
    'Lịch trình bận rộn',
    'Vấn đề sức khỏe',
    'Không thể truy cập địa điểm',
    'Không đủ tài chính',
    'Sự cố công việc đột ngột',
    'Không hài lòng với dịch vụ'
  ];

  String reason = '';
  final _reasonController = TextEditingController();
  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TouchableOpacity(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: 24.sp,
                        ),
                      ),
                      const Text(
                        'Vui lòng cung cấp lý do hủy đơn',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 24.sp,
                        width: 24.sp,
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 16.h,
                  // ),
                  // Text(
                  //   'Bạn đừng hủy đơn hay chọn kĩ thuật viên đang rảnh',
                  //   style: text14.medium,
                  // ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        for (var reason in reasons)
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 8.h),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      this.reason = reason;
                                      _reasonController.text = '';
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      border: Border.all(color: grey400),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 16.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            reason,
                                            style: text14,
                                          ),
                                          if (this.reason == reason)
                                            ImageAssets.svgAssets(
                                              Svg.icCheck,
                                              color: primaryColor,
                                              width: 16.w,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Lý do khác',
                            style: text16.medium,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          AppInput(
                            controller: _reasonController,
                            onChanged: (p0) {
                              setState(() {
                                reason = p0;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonPrimary(
                      color: primaryColor.withOpacity(0.1),
                      text: 'Đóng',
                      onPress: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ButtonPrimary(
                      color:
                          reason.isNotEmpty ? redColor : Colors.grey.shade300,
                      colorText:
                          reason.isNotEmpty ? whiteColor : Colors.grey.shade400,
                      text: 'Hủy đơn',
                      onPress: () {
                        Navigator.pop(
                          context,
                          CancelReason(
                            reason: reason,
                            description: '',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CancelReason {
  final String reason;
  final String description;
  CancelReason({required this.reason, required this.description});
}
