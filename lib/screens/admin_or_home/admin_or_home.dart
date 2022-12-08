import 'package:auto_spare_part/screens/app_router.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/button_widget.dart';

class AdminOrHomePage extends StatelessWidget {
  const AdminOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonWidget(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.bottomNav);
                      },
                      buttonName: 'Home'),
                  SizedBox(height: 18.h),
                  buttonWidget(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.admin);
                      },
                      buttonName: 'Admin'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
