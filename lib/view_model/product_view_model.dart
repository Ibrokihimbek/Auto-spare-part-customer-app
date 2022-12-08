import 'dart:async';

import 'package:auto_spare_part/data/app_repositroy/products_repository.dart';
import 'package:auto_spare_part/data/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository productRepository;
  ProductViewModel({required this.productRepository});

  late StreamSubscription subscription;

  List<ProductModel> products = [];

  listenProducts() async {
    subscription = productRepository.getProducts().listen((allProducts) {
      products = allProducts;
      notifyListeners();
    });
  }

  addProduct(ProductModel productModel) =>
      productRepository.addProduct(productModel: productModel);

  updateProduct(ProductModel productModel) =>
      productRepository.updateProduct(productModel: productModel);

  deleteProduct(String docId) => productRepository.deleteProduct(docId: docId);

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
