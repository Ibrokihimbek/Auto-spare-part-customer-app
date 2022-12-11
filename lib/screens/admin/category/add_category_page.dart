import 'package:auto_spare_part/data/models/category_model.dart';
import 'package:auto_spare_part/data/service/file_uploader.dart';
import 'package:auto_spare_part/utils/app_colors.dart';
import 'package:auto_spare_part/utils/app_images.dart';
import 'package:auto_spare_part/view_model/category_view_model.dart';
import 'package:auto_spare_part/widgets/button_large.dart';
import 'package:auto_spare_part/widgets/font_style_widget.dart';
import 'package:auto_spare_part/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String imageUrl = "";
  bool isLoading = false;
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
                        maxLines: 4,
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
                          onTap: () {
                            _showPicker(context);
                          },
                          buttonName: 'kategoryaga rasm tanlash'),
                      SizedBox(height: 8.h),
                      buttonLargeWidget(
                          onTap: () {
                            CategoryModel categoryModel = CategoryModel(
                              categoryId: "",
                              categoryName: addCategoryCantroller.text,
                              description:
                                  addCategoryDescriptionCantroller.text,
                              imageUrl: imageUrl.isEmpty
                                  ? AppImages.image_car
                                  : imageUrl,
                              createdAt: DateTime.now().toString(),
                            );
                            Provider.of<CategoryViewModel>(context,
                                    listen: false)
                                .addCategory(categoryModel);
                            Navigator.pop(context);
                          },
                          buttonName: 'Add Category'),
                      Container(
                        width: 100,
                        height: 100,
                        child: imageUrl.isEmpty
                            ? Image.asset(AppImages.image_car)
                            : Image.network(imageUrl),
                      )
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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: SvgPicture.asset(
                      AppImages.icon_galery,
                      height: 40.h,
                    ),
                    title: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: SvgPicture.asset(
                    AppImages.icon_camera_upload_photo,
                    height: 40.h,
                  ),
                  title: const Text('Camera'),
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1000,
      maxHeight: 1000,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      imageUrl = await FileUploader.imageUploader(pickedFile, 'categoryImages');
      setState(() {
        isLoading = false;
        _image = pickedFile;
      });
    }
  }

  _getFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1920,
      maxHeight: 2000,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      imageUrl = await FileUploader.imageUploader(pickedFile, 'categoryImages');
      setState(() {
        _image = pickedFile;
      });
    }
  }
}
