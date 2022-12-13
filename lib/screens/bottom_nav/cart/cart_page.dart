import 'package:auto_spare_part/data/models/order_model.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/view_model/order_view_model.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Consumer<OrdersViewModel>(
          builder: (context, orderViewModel, child) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: orderViewModel.userOrders.length,
              itemBuilder: (context, index) {
                return orderItem(orderViewModel.userOrders[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget orderItem(OrderModel order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6).r,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.C_FAFAFA.withOpacity(0.50),
        ),
        width: double.infinity,
        height: 110.h,
        child: Padding(
          padding: const EdgeInsets.all(12).r,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product name: ${order.productName}',
                    style: fontPoppinsW400(appcolor: AppColors.white),
                  ),
                  Text(
                    'Total price: \$${order.totalPrice}',
                    style: fontPoppinsW600(appcolor: AppColors.C_FFC567),
                  ),
                  Text(
                    'Product count: ${order.count}',
                    style: fontPoppinsW400(appcolor: AppColors.white),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Provider.of<OrdersViewModel>(
                    context,
                    listen: false,
                  ).deleteOrder(order.orderId);
                },
                child: SvgPicture.asset(AppImages.icon_delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
