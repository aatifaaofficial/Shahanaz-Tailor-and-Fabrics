import 'package:flutter/material.dart';

import '../../data/demo_data.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final order = DemoData.orders.firstWhere((item) => item.id == orderId, orElse: () => DemoData.orders.first);
    final timeline = [
      'Order Placed',
      'Order Confirmed',
      'Processing',
      'Making',
      'Ready',
      'Out for Delivery',
      'Delivered',
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Order $orderId')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(order.imageUrl, width: 90, height: 90, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order.productName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                          const SizedBox(height: 6),
                          Text(order.date, style: const TextStyle(color: Colors.black54)),
                          const SizedBox(height: 8),
                          Text('Amount: ₹${order.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Tracking', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: timeline.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final step = timeline[index];
                  final active = index <= 3;
                  return Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: active ? const Color(0xFFEFB6C8) : Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                          ),
                          if (index < timeline.length - 1)
                            Container(
                              width: 2,
                              height: 34,
                              color: active ? const Color(0xFFEFB6C8) : Colors.grey.shade300,
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Text(step, style: TextStyle(fontWeight: active ? FontWeight.w700 : FontWeight.w500)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
