import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      {'label': 'Total Products', 'value': '120'},
      {'label': 'Total Orders', 'value': '845'},
      {'label': 'Pending Orders', 'value': '34'},
      {'label': 'Completed Orders', 'value': '712'},
      {'label': 'Total Customers', 'value': '2.4K'},
    ];

    final management = [
      ('Products', Icons.inventory_2_outlined),
      ('Categories', Icons.category_outlined),
      ('Fabrics', Icons.texture_outlined),
      ('Orders', Icons.receipt_long_outlined),
      ('Customers', Icons.people_alt_rounded),
      ('Reviews', Icons.star_half_rounded),
      ('Discounts', Icons.local_offer_outlined),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: metrics.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  final metric = metrics[index];
                  return InkWell(
                    onTap: () => context.push('/products'),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(metric['label']!, style: const TextStyle(color: Colors.black54)),
                          const SizedBox(height: 8),
                          Text(metric['value']!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text('Management', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: management.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
                  final item = management[index];
                  final route = switch (item.$1) {
                    'Products' => '/products',
                    'Orders' => '/orders',
                    'Customers' => '/profile',
                    'Fabrics' => '/fabrics',
                    _ => '/products',
                  };
                  return InkWell(
                    onTap: () => context.push(route),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item.$2, size: 30),
                          const SizedBox(height: 10),
                          Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
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
