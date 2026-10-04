import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    final subtotal = items.fold<double>(0, (sum, item) => sum + item.total);
    final customizationCost = items.length * 499.0;
    final deliveryFee = items.isEmpty ? 0.0 : 149.0;
    final total = subtotal + customizationCost + deliveryFee;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: SafeArea(
        child: items.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined, size: 64, color: AppTheme.plum),
                    SizedBox(height: 16),
                    Text('Your cart is empty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(18),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(item.imageUrl, width: 90, height: 90, fit: BoxFit.cover),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 6),
                                    Text('Size: ${item.size} • Color: ${item.color}', style: const TextStyle(color: Colors.black54)),
                                    const SizedBox(height: 8),
                                    Text('₹${item.total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () => ref.read(cartProvider.notifier).updateQuantity(item.id, 1),
                                    icon: const Icon(Icons.add),
                                  ),
                                  Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.w700)),
                                  IconButton(
                                    onPressed: () => ref.read(cartProvider.notifier).updateQuantity(item.id, -1),
                                    icon: const Icon(Icons.remove),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => ref.read(cartProvider.notifier).removeItem(item.id),
                                    icon: const Icon(Icons.delete_outline_rounded, size: 16),
                                    label: const Text('Remove', style: TextStyle(fontSize: 12)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: Column(
                      children: [
                        _SummaryRow(label: 'Subtotal', amount: subtotal),
                        _SummaryRow(label: 'Customization Cost', amount: customizationCost),
                        _SummaryRow(label: 'Delivery Fee', amount: deliveryFee),
                        const Divider(),
                        _SummaryRow(label: 'Total', amount: total, isTotal: true),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () => context.push('/checkout'),
                            style: FilledButton.styleFrom(backgroundColor: AppTheme.plum, padding: const EdgeInsets.symmetric(vertical: 16)),
                            child: const Text('Proceed to Checkout'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.amount, this.isTotal = false});

  final String label;
  final double amount;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500)),
          const Spacer(),
          Text('₹${amount.toStringAsFixed(0)}', style: TextStyle(fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600, fontSize: isTotal ? 22 : 16)),
        ],
      ),
    );
  }
}
