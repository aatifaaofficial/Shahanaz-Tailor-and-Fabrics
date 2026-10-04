import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/demo_data.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Processing', 'Completed', 'Cancelled'];
    final orders = DemoData.orders;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: tabs.map((tab) {
              final filtered = tab == 'All'
                  ? orders
                  : orders.where((order) => order.status == tab).toList();
              return filtered.isEmpty
                  ? const Center(child: Text('No orders yet'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(18),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final order = filtered[index];
                        return GestureDetector(
                          onTap: () => context.push('/order/${order.id}'),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(order.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(order.productName, style: const TextStyle(fontWeight: FontWeight.w700)),
                                      const SizedBox(height: 6),
                                      Text('Order ID: ${order.id}', style: const TextStyle(color: Colors.black54)),
                                      const SizedBox(height: 4),
                                      Text(order.date, style: const TextStyle(color: Colors.black54)),
                                      const SizedBox(height: 8),
                                      Text('₹${order.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF6E7EA),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(order.status, style: const TextStyle(fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
