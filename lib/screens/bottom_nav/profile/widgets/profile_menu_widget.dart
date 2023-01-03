import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenuWidget extends StatelessWidget {
  final String iconSettings;
  final String settingsName;
  final VoidCallback onTap;

  const ProfileMenuWidget({
    super.key,
    required this.iconSettings,
    required this.settingsName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 48.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(iconSettings),
                    SizedBox(width: 10.w),
                    Text(settingsName,
                        style: fontPoppinsW400(appcolor: AppColors.white))
                  ],
                ),
                SvgPicture.asset(
                  AppImages.icon_arrow_left,
                ),
              ],
            ),
          ),
        ),
      ],
    );
    ;
  }
}
