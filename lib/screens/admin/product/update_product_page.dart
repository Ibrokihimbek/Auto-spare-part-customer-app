import 'package:auto_spare_part/data/models/category_model.dart';
import 'package:auto_spare_part/data/models/product_model.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/view_model/category_view_model.dart';
import 'package:auto_spare_part/view_model/product_view_model.dart';
import 'package:auto_spare_part/widgets/button_large.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:auto_spare_part/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpdateProductPage extends StatefulWidget {
  final ProductModel productModel;
  const UpdateProductPage({super.key, required this.productModel});

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController countController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<String> productImages = [
    "https://www.pngitem.com/pimgs/m/183-1831803_laptop-collection-png-transparent-png.png",
    "https://www.pngitem.com/pimgs/m/183-1831803_laptop-collection-png-transparent-png.png",
  ];
  String categoryId = "";
  CategoryModel? categoryModel;
  List<String> currencies = ["USD", "SO'M", "RUBL", "TENGE"];
  String selectedCurrency = "USD";

  @override
  void initState() {
    countController.text = widget.productModel.count.toString();
    priceController.text = widget.productModel.price.toString();
    nameController.text = widget.productModel.productName;
    descriptionController.text = widget.productModel.description;
    categoryId = widget.productModel.categoryId;
    selectedCurrency = widget.productModel.currency;
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Consumer<ProductViewModel>(
                builder: ((context, productViewModel, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),
                        Text(
                          'Mahsulot soni yangilash',
                          style: fontPoppinsW400(appcolor: AppColors.white)
                              .copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: countController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (product) =>
                              product != null && product.length < 2
                                  ? "Mahsulot sonini 2 tadan ko'p kiriting"
                                  : null,
                          style: fontPoppinsW400(appcolor: AppColors.white),
                          decoration: getInputDecoration(label: ''),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Mahsulot narxini yangilash',
                          style: fontPoppinsW400(appcolor: AppColors.white)
                              .copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: priceController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (product) =>
                              product != null && product.length < 2
                                  ? "Mahsulot narxini 2 dan ko'p kiriting"
                                  : null,
                          style: fontPoppinsW400(appcolor: AppColors.white),
                          decoration: getInputDecoration(label: ''),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Mahsulot nomini yangilash',
                          style: fontPoppinsW400(appcolor: AppColors.white)
                              .copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (product) => product != null &&
                                  product.length < 6
                              ? "Mahsulot nomini 6 ta belgidan ko'p kiriting"
                              : null,
                          style: fontPoppinsW400(appcolor: AppColors.white),
                          decoration: getInputDecoration(label: ''),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "Mahsulot haqida ma'lumotni yangilash",
                          style: fontPoppinsW400(appcolor: AppColors.white)
                              .copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          maxLines: 4,
                          controller: descriptionController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (product) =>
                              product != null && product.length < 6
                                  ? "Ma'lumotni 6 ta belgidan ko'p kiriting"
                                  : null,
                          style: fontPoppinsW400(appcolor: AppColors.white),
                          decoration: getInputDecoration(label: ""),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Pul birligini yangilash",
                          style: fontPoppinsW400(appcolor: AppColors.white)
                              .copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.white,
                              width: 1.w,
                            ),
                          ),
                          child: ExpansionTile(
                            title: Text(
                              selectedCurrency.isEmpty
                                  ? "Select  Currncy"
                                  : selectedCurrency,
                              style: fontPoppinsW400(appcolor: AppColors.white),
                            ),
                            children: [
                              ...List.generate(
                                currencies.length,
                                (index) => ListTile(
                                  title: Text(
                                    currencies[index],
                                    style: fontPoppinsW400(
                                        appcolor: AppColors.white),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedCurrency = currencies[index];
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        buttonLargeWidget(
                          onTap: () {
                            selectCategory((selectedCategory) {
                              categoryModel = selectedCategory;
                              categoryId = categoryModel!.categoryId;
                              setState(() {});
                            });
                          },
                          buttonName: categoryModel == null
                              ? "Kategoryani almashtirish"
                              : categoryModel!.categoryName,
                        ),
                        SizedBox(height: 12.h),
                        buttonLargeWidget(
                            onTap: () {
                              ProductModel productModel = ProductModel(
                                count: int.parse(countController.text),
                                price: int.parse(priceController.text),
                                productImages: productImages,
                                categoryId: categoryId,
                                productId: widget.productModel.productId,
                                productName: nameController.text,
                                description: descriptionController.text,
                                createdAt: widget.productModel.createdAt,
                                currency: selectedCurrency,
                              );

                              Provider.of<ProductViewModel>(context,
                                      listen: false)
                                  .updateProduct(productModel);
                              Navigator.pop(context);
                            },
                            buttonName: "Mahsulotni qo'shish"),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  selectCategory(ValueChanged<CategoryModel> onCategorySelect) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            child: Consumer<CategoryViewModel>(
              builder: ((context, categoryViewModel, child) {
                return ListView(
                  children: List.generate(
                    categoryViewModel.categories.length,
                    (index) => ListTile(
                      title: Text(
                        categoryViewModel.categories[index].categoryName,
                      ),
                      onTap: () {
                        onCategorySelect
                            .call(categoryViewModel.categories[index]);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
