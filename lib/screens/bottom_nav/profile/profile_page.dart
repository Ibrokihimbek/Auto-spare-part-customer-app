import 'dart:io';
import 'package:auto_spare_part/data/service/file_uploader.dart';
import 'package:auto_spare_part/screens/bottom_nav/profile/widgets/profile_menu_widget.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String imageUrl = "";
  bool isLoading = false;
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
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: imageUrl.isEmpty
                        ? const DecorationImage(
                            image: AssetImage(AppImages.image_car),
                            fit: BoxFit.cover)
                        : DecorationImage(
                            image: NetworkImage(imageUrl), fit: BoxFit.cover),
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
                  onTap: () {
                    _showPicker(context);
                  },
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: SvgPicture.asset(
                      AppImages.icon_galery,
                      height: 40.h,
                    ),
                    title: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: SvgPicture.asset(
                    AppImages.icon_camera_upload_photo,
                    height: 40.h,
                  ),
                  title: const Text('Camera'),
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1000,
      maxHeight: 1000,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      imageUrl = await FileUploader.imageUploader(pickedFile, 'profileImages');
      setState(() {
        isLoading = false;
        _image = pickedFile;
      });
    }
  }

  _getFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1920,
      maxHeight: 2000,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      imageUrl = await FileUploader.imageUploader(pickedFile, 'profileImages');
      setState(() {
        _image = pickedFile;
      });
    }
  }
}
