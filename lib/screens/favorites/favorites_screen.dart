import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../data/demo_data.dart';
import '../../providers/favorite_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final products = DemoData.products.where((product) => favorites.contains(product.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: SafeArea(
        child: products.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border_rounded, size: 64, color: AppTheme.plum),
                    SizedBox(height: 16),
                    Text('Your favorites are waiting for you ❤️', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () => context.push('/product/${product.id}'),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.network(product.imageUrl, width: 100, height: 100, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                                const SizedBox(height: 6),
                                Text(product.category, style: const TextStyle(color: Colors.black54)),
                                const SizedBox(height: 8),
                                Text('₹${product.effectivePrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => ref.read(favoritesProvider.notifier).toggleFavorite(product.id),
                            icon: const Icon(Icons.favorite_rounded, color: Colors.pink),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
