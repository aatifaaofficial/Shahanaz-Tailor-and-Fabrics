import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/demo_data.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorite_provider.dart';
import '../../models/cart_item.dart';
import '../../core/theme/app_theme.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = DemoData.products.firstWhere((item) => item.id == productId, orElse: () => DemoData.products.first);
    final isFavorite = ref.watch(favoritesProvider).contains(product.id);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(product.imageUrl, height: 360, width: double.infinity, fit: BoxFit.cover),
                  Positioned(
                    top: 18,
                    left: 18,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 18,
                    right: 18,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () => ref.read(favoritesProvider.notifier).toggleFavorite(product.id),
                        icon: Icon(
                          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: isFavorite ? Colors.pink : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(product.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                    ),
                    Text(product.tag ?? '', style: const TextStyle(color: AppTheme.plum, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber),
                    Text('${product.rating} (${product.reviewCount} reviews)', style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('₹${product.effectivePrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                    const SizedBox(width: 12),
                    if (product.discountedPrice != null)
                      Text('₹${product.price.toStringAsFixed(0)}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                child: Text(product.description, style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.5)),
              ),
              _InfoRow(title: 'Fabric', value: product.fabric),
              _InfoRow(title: 'Available colors', value: product.colors.join(', ')),
              _InfoRow(title: 'Available sizes', value: product.sizes.join(', ')),
              _InfoRow(title: 'Stock status', value: product.inStock ? 'In stock' : 'Out of stock'),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Reviews', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 34),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final review = DemoData.reviews[index % DemoData.reviews.length];
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(backgroundImage: NetworkImage(review.imageUrl), radius: 16),
                              const SizedBox(width: 8),
                              Text(review.userName, style: const TextStyle(fontWeight: FontWeight.w600)),
                              const Spacer(),
                              Row(children: List.generate(5, (i) => Icon(Icons.star_rounded, size: 14, color: i < review.rating ? Colors.amber : Colors.grey.shade300))),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(review.comment),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ref.read(cartProvider.notifier).addItem(
                            CartItem(
                              id: '${product.id}-cart',
                              productId: product.id,
                              name: product.name,
                              imageUrl: product.imageUrl,
                              price: product.effectivePrice,
                              quantity: 1,
                              size: product.sizes.first,
                              color: product.colors.first,
                              customizationDetails: 'Standard fit',
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to cart')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: AppTheme.plum),
                          foregroundColor: AppTheme.plum,
                        ),
                        child: const Text('Add to Cart'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => context.push('/checkout'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: AppTheme.plum,
                        ),
                        child: const Text('Buy Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 130, child: Text(title, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
