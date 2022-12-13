import 'package:auto_spare_part/data/models/order_model.dart';
import 'package:auto_spare_part/data/models/product_model.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/utils/time_utils.dart';
import 'package:auto_spare_part/view_model/order_view_model.dart';
import 'package:auto_spare_part/widgets/button_large.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
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
  int count = 1;
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
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                if (count > 1) {
                                  count--;
                                }
                              });
                            },
                            child: buttonCotrol(AppImages.icon_arrow_down)),
                        SizedBox(width: 8.w),
                        Text(
                          '$count',
                          style: fontPoppinsW400(appcolor: AppColors.white)
                              .copyWith(fontSize: 13.sp),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                            onTap: () {
                              setState(() {
                                count++;
                              });
                            },
                            child: buttonCotrol(AppImages.icon_arrpw_up)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12).r,
                child: Text(
                  'Soni:  ${widget.productModel.count} ta',
                  style: fontPoppinsW400(appcolor: AppColors.white),
                ),
              ),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, left: 12, bottom: 24).r,
                child: buttonLargeWidget(
                    onTap: () {
                      List<OrderModel> orders =
                          Provider.of<OrdersViewModel>(context, listen: false)
                              .userOrders;

                      List<OrderModel> exists = orders
                          .where((e) =>
                              e.productId == widget.productModel.productId)
                          .toList();

                      if (exists.isNotEmpty) {
                        for (var element in orders) {
                          if (element.productId ==
                              widget.productModel.productId) {
                            Provider.of<OrdersViewModel>(context, listen: false)
                                .updateOrderIfExists(
                                    productId: element.productId, count: count);
                          }
                        }
                      } else {
                        Provider.of<OrdersViewModel>(context, listen: false)
                            .addOrder(
                          OrderModel(
                            count: count,
                            totalPrice: widget.productModel.price * count,
                            orderId: "",
                            productId: widget.productModel.productId,
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            orderStatus: "ordered",
                            createdAt: DateTime.now().toString(),
                            productName: widget.productModel.productName,
                          ),
                        );
                      }
                    },
                    buttonName: 'Add to cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buttonCotrol(String iconName) {
    return Container(
      width: 30.w,
      height: 30.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 1),
      ),
      child: Center(
        child: SvgPicture.asset(
          iconName,
        ),
      ),
    );
  }
}
