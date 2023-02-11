import 'package:auto_spare_part/screens/bottom_nav/info_store/widgets/widget.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/screens/bottom_nav/info_store/lat_long/lat_long.dart';
import 'package:auto_spare_part/utils/app_lotties.dart';
import 'package:auto_spare_part/view_model/info_view_model.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoStorePage extends StatefulWidget {
  const InfoStorePage({super.key});

  @override
  State<InfoStorePage> createState() => _InfoStorePageState();
}

class _InfoStorePageState extends State<InfoStorePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Consumer<InfoViewModel>(
          builder: (contex, viewModel, child) {
            if (viewModel.information.isNotEmpty) {
              var infoStore = viewModel.information.first;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  infoStoreItem(
                      title: 'Sotuvchining ismi:',
                      subtitle: infoStore.sellerName,
                      icon: AppImages.icon_profile),
                  SizedBox(height: 24.h),
                  infoStoreItem(
                    title: 'telefon raqami:',
                    subtitle: infoStore.sellerPhoneNumber,
                    icon: AppImages.icon_call,
                    onTap: () async {
                      final Uri phoneUri =
                          Uri(scheme: "tel", path: infoStore.sellerPhoneNumber);
                      try {
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        }
                      } catch (error) {
                        throw ("Cannot dial");
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                  infoStoreItem(
                    title: "Do'kon manzili:",
                    subtitle: infoStore.address,
                    icon: AppImages.icon_home,
                  ),
                  SizedBox(height: 20.h),
                  infoStoreItem(
                    title: "Manzilni xaritadan ko'rish:",
                    subtitle: "Harita belgisiga bosing ➣",
                    onTap: () {
                      LatLong.openMap(
                        double.parse(infoStore.lat),
                        double.parse(infoStore.long),
                      );
                    },
                    icon: AppImages.icon_location,
                  ),
                  SizedBox(height: 24.h),
                  infoStoreItem(
                      title: "Do'kon haqida ma'lumot:",
                      subtitle: infoStore.infoStore,
                      icon: AppImages.icon_description),
                ],
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
      ),
    );
  }
}
