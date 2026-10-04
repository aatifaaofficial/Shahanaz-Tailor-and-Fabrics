import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../data/demo_data.dart';

class FabricDetailsScreen extends StatelessWidget {
  const FabricDetailsScreen({super.key, required this.fabricId});

  final String fabricId;

  @override
  Widget build(BuildContext context) {
    final fabric = DemoData.fabrics.firstWhere((item) => item.id == fabricId, orElse: () => DemoData.fabrics.first);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(fabric.imageUrl, height: 270, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              Text(fabric.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Text('₹${fabric.price}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppTheme.plum)),
              const SizedBox(height: 18),
              Text(fabric.description, style: const TextStyle(height: 1.6, color: Colors.black87)),
              const SizedBox(height: 24),
              _InfoTile(label: 'Suitable season', value: fabric.season),
              _InfoTile(label: 'Appearance', value: fabric.appearance),
              _InfoTile(label: 'Care instructions', value: fabric.careInstructions),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
