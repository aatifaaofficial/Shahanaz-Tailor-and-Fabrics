import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product_model.dart';

final favoritesProvider = StateNotifierProvider<FavoriteNotifier, List<String>>((ref) {
  return FavoriteNotifier();
});

class FavoriteNotifier extends StateNotifier<List<String>> {
  FavoriteNotifier() : super(const []);

  bool isFavorite(String id) => state.contains(id);

  void toggleFavorite(String id) {
    if (state.contains(id)) {
      state = state.where((value) => value != id).toList();
    } else {
      state = [...state, id];
    }
  }

  List<ProductModel> filterProducts(List<ProductModel> products) {
    return products.where((product) => state.contains(product.id)).toList();
  }
}
