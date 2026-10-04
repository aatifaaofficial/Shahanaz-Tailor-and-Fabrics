import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      ('How do I place an order?', 'Browse products or customize your design, add to cart, and complete checkout.'),
      ('How do I customize a dress?', 'Go to Customize and follow the step-by-step designer flow to select style, fabric, measurements, and more.'),
      ('How can I save measurements?', 'Use the Saved Measurements screen to add or edit your regular size profile.'),
      ('How do I track my order?', 'Visit the My Orders tab and open the tracking timeline for your order.'),
      ('How can I cancel an order?', 'Contact support from this section before the order enters final production.'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FAQ', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              ...faqs.map((faq) => ExpansionTile(
                    title: Text(faq.$1),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(faq.$2, style: const TextStyle(height: 1.5)),
                      ),
                    ],
                  )),
              const SizedBox(height: 24),
              Text('Contact Support', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              const ListTile(leading: Icon(Icons.call_outlined), title: Text('+91 98765 43210')),
              const ListTile(leading: Icon(Icons.email_outlined), title: Text('support@shahanazfashion.com')),
            ],
          ),
        ),
      ),
    );
  }
}
