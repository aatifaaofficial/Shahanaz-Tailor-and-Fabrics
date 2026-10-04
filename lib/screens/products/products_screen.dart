import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../providers/favorite_provider.dart';
import '../../providers/product_provider.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  String _selectedCategory = 'All';
  String _sort = 'Recommended';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> get categories => ['All', 'Dresses', 'Party Wear', 'Sarees', 'Salwar Kameez', 'Custom Designs'];

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    final favorites = ref.watch(favoritesProvider);
    final filtered = products.where((product) {
      final matchesCategory = _selectedCategory == 'All' || product.category == _selectedCategory;
      final matchesSearch = _searchController.text.trim().isEmpty || product.name.toLowerCase().contains(_searchController.text.toLowerCase()) || product.fabric.toLowerCase().contains(_searchController.text.toLowerCase()) || product.category.toLowerCase().contains(_searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    if (_sort == 'Price: Low to High') {
      filtered.sort((a, b) => a.effectivePrice.compareTo(b.effectivePrice));
    } else if (_sort == 'Price: High to Low') {
      filtered.sort((a, b) => b.effectivePrice.compareTo(a.effectivePrice));
    } else if (_sort == 'Rating') {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          IconButton(
            onPressed: () => context.push('/favorites'),
            icon: const Icon(Icons.favorite_border_rounded),
          ),
          IconButton(
            onPressed: () => context.push('/cart'),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search dresses, fabrics & designs...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final selected = category == _selectedCategory;
                    return ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedCategory = category),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Sort by'),
                  const Spacer(),
                  DropdownButton<String>(
                    value: _sort,
                    items: ['Recommended', 'Price: Low to High', 'Price: High to Low', 'Rating']
                        .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                        .toList(),
                    onChanged: (value) => setState(() => _sort = value ?? 'Recommended'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (filtered.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off_rounded, size: 52, color: AppTheme.plum),
                        const SizedBox(height: 12),
                        const Text('No dresses found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text('Try another keyword or filter', style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: filtered.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      final product = filtered[index];
                      final isFavorite = favorites.contains(product.id);
                      return GestureDetector(
                        onTap: () => context.push('/product/${product.id}'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10)],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                                    child: Image.network(product.imageUrl, height: 170, width: double.infinity, fit: BoxFit.cover),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: () => ref.read(favoritesProvider.notifier).toggleFavorite(product.id),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, size: 14, color: Colors.amber),
                                        Text('${product.rating}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text('₹${product.effectivePrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
