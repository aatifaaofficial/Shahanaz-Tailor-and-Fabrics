import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../models/cart_item.dart';
import '../../models/custom_dress_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/customization_provider.dart';

class CustomDressDesignerScreen extends ConsumerStatefulWidget {
  const CustomDressDesignerScreen({super.key});

  @override
  ConsumerState<CustomDressDesignerScreen> createState() => _CustomDressDesignerScreenState();
}

class _CustomDressDesignerScreenState extends ConsumerState<CustomDressDesignerScreen> {
  int _step = 0;
  String _dressType = 'Kurti';
  String _fabric = 'Silk';
  String _color = 'Blush';
  String _neck = 'Round';
  String _sleeve = 'Sleeveless';
  String _length = 'Midi';
  String _size = 'M';
  final Map<String, String> _measurements = {
    'Shoulder': '16',
    'Chest': '32',
    'Waist': '28',
    'Hip': '34',
    'Sleeve Length': '18',
    'Dress Length': '36',
  };

  final List<String> _dressTypes = ['Kurti', 'Salwar Kameez', 'Gown', 'Party Dress', 'Lehenga', 'Three-Piece', 'Custom Design'];
  final List<String> _fabrics = ['Cotton', 'Silk', 'Linen', 'Chiffon', 'Georgette', 'Velvet', 'Organza'];
  final List<String> _colors = ['Blush', 'Rose', 'Ivory', 'Peach', 'Plum', 'Gold', 'Sage'];
  final List<String> _necks = ['Round', 'V-Neck', 'Boat Neck', 'Square', 'Collar', 'Designer'];
  final List<String> _sleeves = ['Sleeveless', 'Short', 'Three Quarter', 'Full', 'Bell Sleeve', 'Designer'];
  final List<String> _lengths = ['Mini', 'Midi', 'Ankle', 'Floor Length', 'Long'];
  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'Custom Measurement'];

  void _nextStep() {
    if (_step < 9) setState(() => _step++);
  }

  void _prevStep() {
    if (_step > 0) setState(() => _step--);
  }

  void _submit() {
    final model = CustomDressModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      dressType: _dressType,
      fabric: _fabric,
      color: _color,
      neckDesign: _neck,
      sleeve: _sleeve,
      length: _length,
      size: _size,
      measurements: _measurements,
      estimatedPrice: 3999 + (Random().nextInt(3500) + 1000),
    );
    ref.read(customizationProvider.notifier).update(model);
    ref.read(cartProvider.notifier).addItem(
      CartItem(
        id: 'custom-${model.id}',
        productId: model.id,
        name: '${model.dressType} custom design',
        imageUrl: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=800&q=80',
        price: model.estimatedPrice.toDouble(),
        quantity: 1,
        size: _size,
        color: _color,
        customizationDetails: '${model.fabric} • ${model.neckDesign} • ${model.sleeve} • ${model.length}',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Custom design added to cart.')),
    );
    context.push('/cart');
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      _buildOptionSection('Choose Dress Type', _dressTypes, _dressType, (value) => setState(() => _dressType = value)),
      _buildOptionSection('Choose Fabric', _fabrics, _fabric, (value) => setState(() => _fabric = value)),
      _buildColorSection(),
      _buildOptionSection('Choose Neck Design', _necks, _neck, (value) => setState(() => _neck = value)),
      _buildOptionSection('Choose Sleeve', _sleeves, _sleeve, (value) => setState(() => _sleeve = value)),
      _buildOptionSection('Choose Dress Length', _lengths, _length, (value) => setState(() => _length = value)),
      _buildOptionSection('Choose Size', _sizes, _size, (value) => setState(() => _size = value)),
      _buildMeasurementSection(),
      _buildReferenceImageSection(),
      _buildReviewSection(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Dream Dress'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: (_step + 1) / steps.length,
                minHeight: 10,
                backgroundColor: AppTheme.blush,
                color: AppTheme.plum,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 24),
              Expanded(child: steps[_step]),
              const SizedBox(height: 18),
              Row(
                children: [
                  if (_step > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _prevStep,
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), side: const BorderSide(color: AppTheme.plum)),
                        child: const Text('Back'),
                      ),
                    ),
                  if (_step > 0) const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _step < steps.length - 1 ? _nextStep : _submit,
                      style: FilledButton.styleFrom(backgroundColor: AppTheme.plum, padding: const EdgeInsets.symmetric(vertical: 16)),
                      child: Text(_step < steps.length - 1 ? 'Next' : 'Order This Design'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionSection(String title, List<String> options, String selected, void Function(String option) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 18),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: options.map((option) {
            final isSelected = option == selected;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  onSelect(option);
                }
              },
              selectedColor: AppTheme.blush,
              labelStyle: TextStyle(color: isSelected ? AppTheme.plum : Colors.black87, fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildColorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose Color', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 18),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: _colors.map((color) {
            final isSelected = _color == color;
            final colorMap = {'Blush': const Color(0xFFEFC6D9), 'Rose': const Color(0xFFDB8DA6), 'Ivory': const Color(0xFFF7F0E9), 'Peach': const Color(0xFFF7C8B5), 'Plum': const Color(0xFF815B6D), 'Gold': const Color(0xFFD7B66B), 'Sage': const Color(0xFFB6C9B3)};
            return GestureDetector(
              onTap: () => setState(() => _color = color),
              child: Column(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorMap[color] ?? AppTheme.rose,
                      border: Border.all(color: isSelected ? AppTheme.plum : Colors.transparent, width: 3),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(color, style: const TextStyle(fontSize: 12)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMeasurementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Measurements', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 18),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.4,
            children: _measurements.entries.map((entry) {
              return TextFormField(
                initialValue: entry.value,
                onChanged: (value) => _measurements[entry.key] = value,
                decoration: InputDecoration(
                  labelText: entry.key,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReferenceImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reference Image', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 18),
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.blush,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.rose),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.upload_file_rounded, size: 54, color: AppTheme.plum),
                SizedBox(height: 12),
                Text('Upload a reference design image'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Review Design', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ReviewItem(label: 'Dress Type', value: _dressType),
              _ReviewItem(label: 'Fabric', value: _fabric),
              _ReviewItem(label: 'Color', value: _color),
              _ReviewItem(label: 'Neck', value: _neck),
              _ReviewItem(label: 'Sleeve', value: _sleeve),
              _ReviewItem(label: 'Length', value: _length),
              _ReviewItem(label: 'Size', value: _size),
              const Divider(),
              _ReviewItem(label: 'Estimated Price', value: '₹${(3999 + Random().nextInt(3500)).toString()}'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 110, child: Text(label, style: const TextStyle(color: Colors.black54))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
