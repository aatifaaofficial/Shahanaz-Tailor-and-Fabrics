import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/demo_data.dart';
import '../models/order_model.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, List<OrderModel>>((ref) {
  return OrderNotifier();
});

class OrderNotifier extends StateNotifier<List<OrderModel>> {
  OrderNotifier() : super(DemoData.orders);

  List<OrderModel> get byStatus => state;

  void addOrder(OrderModel order) {
    state = [order, ...state];
  }
}
