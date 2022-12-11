import 'package:auto_spare_part/data/models/product_model.dart';
import 'package:auto_spare_part/screens/app_router.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/view_model/product_view_model.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
          child: Consumer<ProductViewModel>(
            builder: (context, productViewModel, child) {
              return GridView.builder(
                shrinkWrap: true,
                itemCount: productViewModel
                    .products.length, //TasksModels.learn.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5 / 3.1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return productItem(productViewModel.products[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget productItem(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteName.productInfo, arguments: {'singleProduct': product});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: AppColors.C_FAFAFA.withOpacity(0.50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 150.w,
                    height: 100.h,
                    child: Image.network(
                      product.productImages[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  product.productName,
                  style: fontPoppinsW400(appcolor: AppColors.white).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '${product.price} ${product.currency}',
                  style: fontPoppinsW600(appcolor: AppColors.C_FFC567),
                ),
                SizedBox(height: 5.5.h),
                Text(
                  '${product.count} dona',
                  style: fontPoppinsW400(appcolor: AppColors.white).copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
