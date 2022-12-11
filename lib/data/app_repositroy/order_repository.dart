import 'package:auto_spare_part/data/models/order_model.dart';
import 'package:auto_spare_part/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRepository {
  final FirebaseFirestore _firestore;
  OrderRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addOrderToCart({required OrderModel orderModel}) async {
    try {
      DocumentReference newOrder =
          await _firestore.collection("orders").add(orderModel.toJson());
      await _firestore
          .collection("orders")
          .doc(newOrder.id)
          .update({"orderId": newOrder.id});
      getMyToast(message: "Mahsulot savatchaga muvaffaqiyatli qo'shildi");
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }

  Stream<List<OrderModel>> getAllOrder() =>
      _firestore.collection("orders").snapshots().map(
            (event1) => event1.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList(),
          );

  Future<void> deleteOrder({required String docId}) async {
    try {
      await _firestore.collection("orders").doc(docId).delete();
      getMyToast(message: "Mahsulot muvaffaqiyatli o'chirildi");
    } on FirebaseException catch (error) {
      getMyToast(message: error.message.toString());
    }
  }
}
