import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/demo_data.dart';
import '../models/product_model.dart';

final productProvider = StateNotifierProvider<ProductNotifier, List<ProductModel>>((ref) {
  return ProductNotifier();
});

class ProductNotifier extends StateNotifier<List<ProductModel>> {
  ProductNotifier() : super(DemoData.products);

  List<ProductModel> searchProducts(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return state;
    return state.where((product) {
      final haystack = [
        product.name,
        product.category,
        product.fabric,
        ...product.colors,
      ].join(' ').toLowerCase();
      return haystack.contains(q);
    }).toList();
  }
}
