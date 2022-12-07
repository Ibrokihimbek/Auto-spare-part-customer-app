import 'package:auto_spare_part/screens/bottom_nav/profile/widgets/profile_menu_widget.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/view_model/profile_view_model.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).r,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: const CircleAvatar(
                    radius: 42.5,
                    backgroundImage: AssetImage(AppImages.image_car),
                  ),
                ),
                SizedBox(height: 10.h),
                
                Text(
                  "${FirebaseAuth.instance.currentUser?.email.toString()}",
                  style: fontPoppinsW500(appcolor: AppColors.white)
                      .copyWith(fontSize: 20.sp),
                ),
                SizedBox(height: 32.h),
                ProfileMenuWidget(
                  menuName: 'Account',
                  iconSettings: AppImages.icon_profile,
                  settingsName: 'Change account name',
                  onTap: () {},
                ),
                ProfileMenuWidget(
                  menuName: null,
                  iconSettings: AppImages.icon_key,
                  settingsName: 'Change account password',
                  onTap: () {},
                ),
                ProfileMenuWidget(
                  menuName: null,
                  iconSettings: AppImages.icon_camera,
                  settingsName: 'Change account Image',
                  onTap: () {},
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 48.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(AppImages.icon_log_out),
                            SizedBox(width: 10.w),
                            Text('Log out',
                                style:
                                    fontPoppinsW400(appcolor: AppColors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
