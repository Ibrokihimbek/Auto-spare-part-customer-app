import 'package:auto_spare_part/screens/admin/widgets/button_widget.dart';
import 'package:auto_spare_part/screens/app_router.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonWidgetbyHomrOrAdmin(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.addCategory);
                    },
                    buttonName: 'Categories'),
                SizedBox(height: 12.h),
                buttonWidgetbyHomrOrAdmin(onTap: () {}, buttonName: 'Products'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
