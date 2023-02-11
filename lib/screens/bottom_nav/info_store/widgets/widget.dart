import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget infoStoreItem({
  String? icon,
  VoidCallback? onTap,
  required String title,
  required String subtitle,
}) {
  return ListTile(
    title: Text(
      title,
      style: fontPoppinsW400(
        appcolor: AppColors.C_FFC567,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: fontPoppinsW400(
        appcolor: AppColors.white,
      ),
    ),
    trailing: InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 30.w,
        height: 30.h,
        child: SvgPicture.asset(
         icon ?? AppImages.icon_star,
          color: AppColors.white,
        ),
      ),
    ),
  );
}
