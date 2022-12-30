import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget PostIndicatorWidget({required int currentIndex, required int itemCount}) {
  return Container(
    margin: const EdgeInsets.only(right: 24).r,
    height: 10.h,
    child: ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 10.h,
          width: 10.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56.r),
            color: currentIndex == index
                ? AppColors.C_FFC567
                : Colors.white,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 4.w,
        );
      },
    ),
  );
}