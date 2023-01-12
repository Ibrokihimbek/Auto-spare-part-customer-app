import 'package:auto_spare_part/data/app_repositroy/profile_repository.dart';
import 'package:auto_spare_part/data/models/user_model.dart';
import 'package:auto_spare_part/data/service/file_uploader.dart';
import 'package:auto_spare_part/screens/bottom_nav/profile/widgets/profile_menu_widget.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/view_model/profile_view_model.dart';
import 'package:auto_spare_part/widgets/button_large.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:auto_spare_part/widgets/input_decoration_widget.dart';
import 'package:auto_spare_part/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String userName = '';
  String imageUrl = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(
        firebaseAuth: FirebaseAuth.instance,
        profileRepository:
            ProfileRepository(firebaseFirestore: FirebaseFirestore.instance),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Consumer<ProfileViewModel>(
              builder: (context, viewModel, child) {
                var userInfo = viewModel.userModel;
                return viewModel.userModel != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24).r,
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: userInfo!.imageUrl == ''
                                    ? const DecorationImage(
                                        image: AssetImage(AppImages.image_car),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(
                                          userInfo.imageUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              userInfo.fullName.isEmpty
                                  ? userInfo.email
                                  : userInfo.fullName,
                              style: fontPoppinsW500(appcolor: AppColors.white)
                                  .copyWith(fontSize: 20.sp),
                            ),
                            SizedBox(height: 32.h),
                            ProfileMenuWidget(
                              iconSettings: AppImages.icon_profile,
                              settingsName: "Nomni o'zgartirish",
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: AppColors.C_393B40,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          border: Border.all(
                                            color: AppColors.white,
                                            width: 1,
                                          ),
                                        ),
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ).r,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 12.h),
                                              TextFormField(
                                                controller: controller,
                                                textInputAction:
                                                    TextInputAction.next,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                style: fontPoppinsW400(
                                                        appcolor:
                                                            AppColors.white)
                                                    .copyWith(fontSize: 17.sp),
                                                decoration: getInputDecoration(
                                                    label:
                                                        "Yangi nom kiriting"),
                                              ),
                                              SizedBox(height: 12.h),
                                              buttonLargeWidget(
                                                  onTap: () {
                                                    Provider.of<ProfileViewModel>(
                                                            context,
                                                            listen: false)
                                                        .updateUser(UserModel(
                                                      age: userInfo.age,
                                                      userId: userInfo.userId,
                                                      docId: userInfo.docId,
                                                      fullName: controller.text,
                                                      email: userInfo.email,
                                                      createdAt: DateTime.now()
                                                          .toString(),
                                                      imageUrl:
                                                          userInfo.imageUrl,
                                                      fcmToken:
                                                          userInfo.fcmToken,
                                                    ));

                                                    Navigator.pop(context);
                                                  },
                                                  buttonName: "O'zgartirish"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            ProfileMenuWidget(
                              iconSettings: AppImages.icon_camera,
                              settingsName: "Suratni o'zgartirish",
                              onTap: () {
                                _showPicker(context, userInfo);
                              },
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await FirebaseAuth.instance.signOut();
                                  },
                                  child: SizedBox(
                                    height: 48.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                            AppImages.icon_log_out),
                                        SizedBox(width: 10.w),
                                        Text(
                                          'Chiqish',
                                          style: fontPoppinsW400(
                                              appcolor: AppColors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context, UserModel userModel) {
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
                      _getFromGallery(userModel);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: SvgPicture.asset(
                    AppImages.icon_camera_upload_photo,
                    height: 40.h,
                  ),
                  title: const Text('Camera'),
                  onTap: () {
                    _getFromCamera(userModel);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getFromGallery(UserModel userInfo) async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1000,
      maxHeight: 1000,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
        getMyToast(message: 'Rasm yuklanmoqda');
      });
      imageUrl = await FileUploader.imageUploader(pickedFile, 'profileImages');
      Provider.of<ProfileViewModel>(context, listen: false).updateUser(
        UserModel(
          age: userInfo.age,
          userId: userInfo.userId,
          docId: userInfo.docId,
          fullName: userInfo.fullName,
          email: userInfo.email,
          createdAt: DateTime.now().toString(),
          imageUrl: imageUrl,
          fcmToken: userInfo.fcmToken,
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  _getFromCamera(UserModel userInfo) async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1920,
      maxHeight: 2000,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
        getMyToast(message: 'Rasm yuklanmoqda');
      });
      imageUrl = await FileUploader.imageUploader(pickedFile, 'profileImages');
      Provider.of<ProfileViewModel>(context, listen: false).updateUser(
        UserModel(
          age: userInfo.age,
          userId: userInfo.userId,
          docId: userInfo.docId,
          fullName: userInfo.fullName,
          email: userInfo.email,
          createdAt: DateTime.now().toString(),
          imageUrl: imageUrl,
          fcmToken: userInfo.fcmToken,
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}
