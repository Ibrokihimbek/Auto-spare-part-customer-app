import 'package:auto_spare_part/screens/bottom_nav/home/home_page.dart';
import 'package:auto_spare_part/screens/bottom_nav/profile/profile_page.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/view_model/bottom_nav_view_model.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens.add(HomePage());
    screens.add(Container());
    screens.add(ProfilePage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var index = context.watch<BottomNavViewModel>().activePageIndex;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.C_3E424B,
            AppColors.C_363941.withOpacity(0.100),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: screens[index],
        bottomNavigationBar: FloatingNavbar(
          backgroundColor: Colors.white,
          selectedBackgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          borderRadius: 15.r,
          onTap: (value) =>
              Provider.of<BottomNavViewModel>(context, listen: false)
                  .changePageIndex(value),
          items: [
            FloatingNavbarItem(
                customWidget: SvgPicture.asset(
                  AppImages.icon_home,
                  color: index == 0 ? AppColors.white : AppColors.C_000000,
                ),
                title: 'Home'),
            FloatingNavbarItem(
                customWidget: SvgPicture.asset(
                  AppImages.icon_cart,
                  color: index == 1 ? AppColors.white : AppColors.C_000000,
                ),
                title: 'Cart'),
            FloatingNavbarItem(
                customWidget: SvgPicture.asset(
                  AppImages.icon_profile,
                  color: index == 2 ? AppColors.white : AppColors.C_000000,
                ),
                title: 'Profile')
          ],
          currentIndex: index,
        ),
      ),
    );
  }
}
