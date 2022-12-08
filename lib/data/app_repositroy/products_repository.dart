import 'package:auto_spare_part/data/models/product_model.dart';
import 'package:auto_spare_part/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  final FirebaseFirestore _firestore;
  ProductRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addProduct({required ProductModel productModel}) async {
    try {
      DocumentReference newProduct =
          await _firestore.collection("products").add(productModel.toJson());
      await _firestore
          .collection("products")
          .doc(newProduct.id)
          .update({"productId": newProduct.id});
      getMyToast(message: 'Product muvaffaqiyatli saqlandi');
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }

  Future<void> deleteProduct({required String docId}) async {
    try {
      await _firestore.collection("products").doc(docId).delete();
      getMyToast(message: 'Product muvaffaqiyatli saqlandi');
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }

  Future<void> updateProduct({required ProductModel productModel}) async {
    try {
      await _firestore
          .collection("products")
          .doc(productModel.productId)
          .update(productModel.toJson());
      getMyToast(message: "Product muvaffaqiyatli yangilandi!");
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }

  Stream<List<ProductModel>> getProducts() =>
      _firestore.collection("products").snapshots().map(
            (querySnapshot) => querySnapshot.docs
                .map((doc) => ProductModel.fromJson(doc.data()))
                .toList(),
          );
}
