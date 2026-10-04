import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../data/demo_data.dart';
import '../../models/product_model.dart';
import '../../providers/favorite_provider.dart';
import '../../providers/product_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);
    final favorites = ref.watch(favoritesProvider);
    final featured = products.take(3).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Hello, Jyoti 👋', style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('Your Style. Your Fabric. Your Dress.', style: TextStyle(color: Colors.black54, fontSize: 12)),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.push('/notifications'),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                readOnly: true,
                onTap: () => context.push('/products'),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  hintText: 'Search dresses, fabrics & designs...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _QuickAction(icon: Icons.style_rounded, label: 'Fabrics', onTap: () => context.push('/fabrics')),
                  const SizedBox(width: 12),
                  _QuickAction(icon: Icons.favorite_rounded, label: 'Favorites', onTap: () => context.push('/favorites')),
                  const SizedBox(width: 12),
                  _QuickAction(icon: Icons.shopping_cart_rounded, label: 'Cart', onTap: () => context.push('/cart')),
                  const SizedBox(width: 12),
                  _QuickAction(icon: Icons.notifications_none_rounded, label: 'Alerts', onTap: () => context.push('/notifications')),
                ],
              ),
              const SizedBox(height: 24),
              _HeroBanner(onPressed: () => context.go('/customize')),
              const SizedBox(height: 28),
              Text('Categories', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: DemoData.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final category = DemoData.categories[index];
                    return GestureDetector(
                      onTap: () => context.push('/products'),
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10)],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(category.imageUrl, width: 70, height: 70, fit: BoxFit.cover),
                            ),
                            const SizedBox(height: 8),
                            Text(category.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              _SectionHeader(title: 'New Arrivals', onSeeAll: () => context.push('/products')),
              const SizedBox(height: 16),
              _ProductList(products: featured, favorites: favorites, onFavorite: (id) => ref.read(favoritesProvider.notifier).toggleFavorite(id)),
              const SizedBox(height: 28),
              _SectionHeader(title: 'Popular Collection', onSeeAll: () => context.push('/products')),
              const SizedBox(height: 16),
              ...products.take(2).map((product) => _FeaturedRowProduct(product: product, isFavorite: favorites.contains(product.id), onTap: () => context.push('/product/${product.id}'))),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(colors: [AppTheme.plum, AppTheme.rose]),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Your Style. Your Measurements. Your Dress.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22)),
                          const SizedBox(height: 12),
                          FilledButton(
                            onPressed: () => context.go('/customize'),
                            style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.plum),
                            child: const Text('Create Your Design'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.design_services_rounded, color: Colors.white, size: 54),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _SectionHeader(title: 'Recommended For You', onSeeAll: () => context.push('/products')),
              const SizedBox(height: 16),
              _ProductList(products: products.take(3).toList(), favorites: favorites, onFavorite: (id) => ref.read(favoritesProvider.notifier).toggleFavorite(id)),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppTheme.plum),
              const SizedBox(height: 6),
              Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=1200&q=80'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Design Your Dream Dress', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.plum),
            child: const Text('Customize Now'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onSeeAll});

  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700))),
        TextButton(onPressed: onSeeAll, child: const Text('See all')),
      ],
    );
  }
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.products, required this.favorites, required this.onFavorite});

  final List<ProductModel> products;
  final List<String> favorites;
  final ValueChanged<String> onFavorite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final product = products[index];
          final isFavorite = favorites.contains(product.id);
          return GestureDetector(
            onTap: () => context.push('/product/${product.id}'),
            child: Container(
              width: 180,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 14)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(product.imageUrl, height: 130, width: double.infinity, fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => onFavorite(product.id),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Icon(
                              isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: isFavorite ? Colors.pink : Colors.black87,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                      Text('${product.rating}', style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('₹${product.effectivePrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FeaturedRowProduct extends StatelessWidget {
  const _FeaturedRowProduct({required this.product, required this.isFavorite, required this.onTap});

  final ProductModel product;
  final bool isFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(product.imageUrl, width: 100, height: 100, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                      Text('${product.rating}', style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('₹${product.effectivePrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                ],
              ),
            ),
            Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: isFavorite ? Colors.pink : Colors.black87),
          ],
        ),
      ),
    );
  }
}
