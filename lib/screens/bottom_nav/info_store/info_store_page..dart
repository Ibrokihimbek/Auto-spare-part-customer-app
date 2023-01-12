import 'package:auto_spare_part/screens/bottom_nav/info_store/widgets/widget.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/utils/app_lotties.dart';
import 'package:auto_spare_part/view_model/info_view_model.dart';
import 'package:auto_spare_part/widgets/button_large.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class InfoStorePage extends StatefulWidget {
  const InfoStorePage({super.key});

  @override
  State<InfoStorePage> createState() => _InfoStorePageState();
}

class _InfoStorePageState extends State<InfoStorePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<InfoViewModel>(
        builder: (contex, viewModel, child) {
          if (viewModel.information.isNotEmpty) {
            var infoStore = viewModel.information.first;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  infoStoreItem(
                    title: 'Sotuvchining ismi:',
                    subtitle: infoStore.sellerName,
                  ),
                  SizedBox(height: 24.h),
                  infoStoreItem(
                    title: 'telefon raqami:',
                    subtitle: infoStore.sellerPhoneNumber,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Do'kon haqida ma'lumot:",
                    style: fontPoppinsW400(
                      appcolor: AppColors.C_FFC567,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      infoStore.infoStore,
                      style: fontPoppinsW400(
                        appcolor: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Do'kon manzili:",
                    style: fontPoppinsW400(
                      appcolor: AppColors.C_FFC567,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      infoStore.address,
                      style: fontPoppinsW400(
                        appcolor: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Manzilni kartadan ko'rish:",
                        style: fontPoppinsW400(
                          appcolor: AppColors.C_FFC567,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: SvgPicture.asset(
                            AppImages.icon_location,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 24,
            ).r,
            child: Column(
              children: [
                Center(
                  child: Lottie.asset(AppLotties.lottie_no_data),
                ),
                Text(
                  "Do'kon haqida ma'lumot yo'q!",
                  textAlign: TextAlign.center,
                  style: fontPoppinsW500(appcolor: AppColors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
