import 'package:auto_spare_part/data/models/product_model.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/time_utils.dart';
import 'package:auto_spare_part/widgets/button_large.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/post_indicator_widget.dart';

class ProductInfoPage extends StatefulWidget {
  final ProductModel productModel;
  const ProductInfoPage({super.key, required this.productModel});

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> {
  int currentIndex = 0;
  PageController pageController = PageController();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.productModel.productName,
                      style: fontPoppinsW500(appcolor: AppColors.white),
                    ),
                    Text(
                      TimeUtils.formatToMyTime(
                        DateTime.parse(widget.productModel.createdAt),
                      ),
                      style: fontPoppinsW400(appcolor: AppColors.white)
                          .copyWith(fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: 400,
                height: 200.h,
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(
                      () {
                        currentIndex = index;
                      },
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  itemCount: widget.productModel.productImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: double.infinity,
                      height: 80.h,
                      child: CachedNetworkImage(
                        imageUrl: widget.productModel.productImages[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Shimmer.fromColors(
                            period: const Duration(seconds: 2),
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: 120,
                              height: 100,
                              color: Colors.white,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20).r,
                  child: PostIndicatorWidget(
                    currentIndex: currentIndex,
                    itemCount: widget.productModel.productImages.length,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12).r,
                child: Text(
                  'Description',
                  style: fontPoppinsW500(appcolor: AppColors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12).r,
                child: SizedBox(
                  width: 300.w,
                  child: Text(
                    widget.productModel.description,
                    style: fontPoppinsW300(
                            appcolor: AppColors.white.withOpacity(0.6))
                        .copyWith(fontSize: 16.sp),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12).r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nraxi:  ${widget.productModel.price} ${widget.productModel.currency}',
                      style: fontPoppinsW600(appcolor: AppColors.C_FFC567),
                    ),
                    Text(
                      'Soni:  ${widget.productModel.count} ta',
                      style: fontPoppinsW400(appcolor: AppColors.white),
                    )
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, left: 12, bottom: 24).r,
                child:
                    buttonLargeWidget(onTap: () {}, buttonName: 'Add to cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
