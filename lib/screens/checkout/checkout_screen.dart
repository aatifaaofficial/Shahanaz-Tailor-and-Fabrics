import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _paymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Section(title: 'Delivery Address', child: const Text('Jyoti Sharma\n123 Rose Lane, Gulmohar Road\nBengaluru, Karnataka 560001')),
              const SizedBox(height: 18),
              _Section(
                title: 'Payment Method',
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('Cash on Delivery'),
                      value: 'Cash on Delivery',
                      groupValue: _paymentMethod,
                      onChanged: (value) => setState(() => _paymentMethod = value ?? 'Cash on Delivery'),
                    ),
                    RadioListTile<String>(
                      title: const Text('Demo Card Payment'),
                      value: 'Demo Card Payment',
                      groupValue: _paymentMethod,
                      onChanged: (value) => setState(() => _paymentMethod = value ?? 'Demo Card Payment'),
                    ),
                    RadioListTile<String>(
                      title: const Text('Mobile Payment UI placeholder'),
                      value: 'Mobile Payment UI placeholder',
                      groupValue: _paymentMethod,
                      onChanged: (value) => setState(() => _paymentMethod = value ?? 'Mobile Payment UI placeholder'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              _Section(
                title: 'Order Summary',
                child: const Column(
                  children: [
                    _PriceRow(label: 'Subtotal', value: 5499),
                    _PriceRow(label: 'Customization Cost', value: 1499),
                    _PriceRow(label: 'Delivery', value: 149),
                    Divider(),
                    _PriceRow(label: 'Total', value: 7147, bold: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.push('/order-success'),
                  style: FilledButton.styleFrom(backgroundColor: AppTheme.plum, padding: const EdgeInsets.symmetric(vertical: 18)),
                  child: const Text('Place Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value, this.bold = false});

  final String label;
  final int value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
          const Spacer(),
          Text('₹${value.toString()}', style: TextStyle(fontWeight: bold ? FontWeight.w800 : FontWeight.w600)),
        ],
      ),
    );
  }
}
