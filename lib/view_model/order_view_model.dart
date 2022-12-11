import 'dart:async';
import 'package:auto_spare_part/data/app_repositroy/order_repository.dart';
import 'package:auto_spare_part/data/models/order_model.dart';
import 'package:flutter/cupertino.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository orderRepository;
  OrderViewModel({required this.orderRepository}) {
    listenOrders();
  }

  late StreamSubscription subscription;

  List<OrderModel> orders = [];

  listenOrders() async {
    subscription = orderRepository.getAllOrder().listen((event) {
      orders = event;
      notifyListeners();
    });
  }

  addOrderToCart({required OrderModel orderModel}) =>
      orderRepository.addOrderToCart(orderModel: orderModel);

  deleteOrder({required String docId}) =>
      orderRepository.deleteOrder(docId: docId);

      @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
