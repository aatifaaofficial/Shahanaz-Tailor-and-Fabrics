import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_item.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super(const []);

  void addItem(CartItem item) {
    final existingIndex = state.indexWhere((cartItem) => cartItem.id == item.id);
    if (existingIndex >= 0) {
      final current = state[existingIndex];
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            current.copyWith(quantity: current.quantity + item.quantity)
          else
            state[i],
      ];
      return;
    }
    state = [...state, item];
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void updateQuantity(String id, int delta) {
    state = [
      for (final item in state)
        if (item.id == id)
          item.copyWith(quantity: (item.quantity + delta).clamp(1, 20))
        else
          item,
    ];
  }

  void clear() => state = const [];
}
