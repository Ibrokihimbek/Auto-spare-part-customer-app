import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/view_model/category_view_model.dart';
import 'package:auto_spare_part/widgets/button_large.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:auto_spare_part/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController addCategoryCantroller = TextEditingController();
  final TextEditingController addCategoryDescriptionCantroller =
      TextEditingController();

  @override
  void initState() {
    Provider.of<CategoryViewModel>(context, listen: false).listenCategories();
    super.initState();
  }

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
        body: Form(
          key: formKey,
          child: SafeArea(
            child: Consumer<CategoryViewModel>(
              builder: ((context, categoryViewModel, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      Text(
                        'Mahsulot nomi',
                        style: fontPoppinsW400(appcolor: AppColors.white)
                            .copyWith(fontSize: 14.sp),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: addCategoryCantroller,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (category) =>
                            category != null && category.length < 6
                                ? "Mahsulot nomini 6 ta belgidan ko'p kiriting"
                                : null,
                        style: fontPoppinsW400(appcolor: AppColors.white),
                        decoration: getInputDecoration(
                            label: 'Mahsulot nomini kiriting'),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        "Mahsulot haqida ma'lumot",
                        style: fontPoppinsW400(appcolor: AppColors.white)
                            .copyWith(fontSize: 14.sp),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: addCategoryDescriptionCantroller,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (category) =>
                            category != null && category.length < 6
                                ? "Ma'lumotni 6 ta belgidan ko'p kiriting"
                                : null,
                        style: fontPoppinsW400(appcolor: AppColors.white),
                        decoration: getInputDecoration(
                            label: "Mahsulot haqida ma'lumot kiriting"),
                      ),
                      SizedBox(height: 30.h),
                      buttonLargeWidget(
                          onTap: () {}, buttonName: 'Add Category'),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
