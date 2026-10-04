import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Shahanaz Tailors & Fabrics is a modern fashion and tailoring platform that brings shopping, fabric selection and custom dress design together in one convenient mobile application.',
                style: TextStyle(height: 1.6),
              ),
              const SizedBox(height: 22),
              _Section(title: 'Mission', content: 'To make premium fashion, custom tailoring and personalized styling accessible and enjoyable for every customer.'),
              _Section(title: 'Services', content: 'Ready-to-wear dresses, fabric shopping, custom design consultations, measurements, tracking, and post-order support.'),
              _Section(title: 'Contact', content: 'hello@shahanazfashion.com\n+91 98765 43210\nInstagram: @shahanaz.tailors'),
              _Section(title: 'Social Media', content: 'Instagram • Facebook • Pinterest • WhatsApp'),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(height: 1.5)),
        ],
      ),
    );
  }
}
