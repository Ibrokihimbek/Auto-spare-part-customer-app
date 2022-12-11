import 'package:auto_spare_part/data/models/category_model.dart';
import 'package:auto_spare_part/screens/app_router.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/view_model/category_view_model.dart';
import 'package:auto_spare_part/view_model/product_view_model.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<CategoryViewModel>(context, listen: false).listenCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<CategoryViewModel>(
        builder: ((context, categoryViewModel, child) {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: categoryViewModel.categories.length,
                itemBuilder: (context, index) {
                  return categoryItem(
                    categoryViewModel.categories[index],
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget categoryItem(CategoryModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6).r,
      child: InkWell(
        onTap: () {
          Provider.of<ProductViewModel>(
            context,
            listen: false,
          ).listenProducts(model.categoryId);
          Navigator.pushNamed(context, RouteName.product);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: AppColors.C_FAFAFA.withOpacity(0.50),
          ),
          width: double.infinity,
          height: 100.h,
          child: Row(
            children: [
              SizedBox(width: 8.w),
              SizedBox(
                width: 80.w,
                height: 80.h,
                child: Image.network(
                  model.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              SizedBox(
                width: 200.h,
                child: Text(
                  model.categoryName,
                  style: fontPoppinsW500(appcolor: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
