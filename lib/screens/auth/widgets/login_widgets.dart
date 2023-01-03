import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginWidgets {
  static Widget logoWidget({required String image}) {
    return Center(
      child: SizedBox(
        width: 70.w,
        height: 70.h,
        child: Image.asset(image),
      ),
    );
  }

  static Widget textWidget({required String title, required String subTitle}) {
    return ListTile(
      title: Text(
        title,
        style: fontPoppinsW600(appcolor: AppColors.white)
            .copyWith(fontSize: 28.sp),
      ),
      subtitle: Text(
        subTitle,
        style: fontPoppinsW400(appcolor: AppColors.white)
            .copyWith(fontSize: 16.sp),
      ),
    );
  }

  static Widget buttonWidget(
      {required String buttonName, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 64.h,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF373737),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              AppColors.C_393B40.withOpacity(0.30),
              AppColors.C_FAFAFA.withOpacity(0.50),
              AppColors.C_393B40.withOpacity(0.30),
            ],
          ),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: fontPoppinsW600(appcolor: AppColors.white).copyWith(
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }

  static Widget buttonWidgetByIcon(
      {required String buttonName,
      required VoidCallback onTap,
      required String iconName}) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 64.h,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF373737),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              AppColors.C_393B40.withOpacity(0.30),
              AppColors.C_FAFAFA.withOpacity(0.50),
              AppColors.C_393B40.withOpacity(0.30),
            ],
          ),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 30.w,
                height: 30.h,
                child: SvgPicture.asset(iconName),
              ),
              Text(
                buttonName,
                style: fontPoppinsW600(appcolor: AppColors.white).copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
