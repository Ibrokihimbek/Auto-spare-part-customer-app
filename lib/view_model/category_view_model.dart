import 'dart:async';

import 'package:auto_spare_part/data/app_repositroy/categories_repository.dart';
import 'package:auto_spare_part/data/models/category_model.dart';
import 'package:flutter/cupertino.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository categoryRepository;
  CategoryViewModel({required this.categoryRepository});

  late StreamSubscription subscription;

  List<CategoryModel> categories = [];

  listenCategories() async {
    subscription = categoryRepository.getCategoties().listen((allCategories) {
      categories = allCategories;
      notifyListeners();
    });
  }

  addCategory(CategoryModel categoryModel) =>
      categoryRepository.addCateegory(categoryModel: categoryModel);

  updateCategory(CategoryModel categoryModel) =>
      categoryRepository.updateCategory(categoryModel: categoryModel);

  deleteCategory(String docId) =>
      categoryRepository.deleteCategory(docId: docId);

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
