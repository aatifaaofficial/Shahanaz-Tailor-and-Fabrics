import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../models/measurement_model.dart';
import '../../providers/measurement_provider.dart';

class MeasurementsScreen extends ConsumerStatefulWidget {
  const MeasurementsScreen({super.key});

  @override
  ConsumerState<MeasurementsScreen> createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends ConsumerState<MeasurementsScreen> {
  Future<void> _openEditor({MeasurementModel? measurement}) async {
    final controllerName = TextEditingController(text: measurement?.profileName ?? 'My Regular Size');
    final controllerShoulder = TextEditingController(text: measurement?.shoulder.toString() ?? '16');
    final controllerChest = TextEditingController(text: measurement?.chest.toString() ?? '32');
    final controllerWaist = TextEditingController(text: measurement?.waist.toString() ?? '28');
    final controllerHip = TextEditingController(text: measurement?.hip.toString() ?? '34');
    final controllerSleeve = TextEditingController(text: measurement?.sleeveLength.toString() ?? '18');
    final controllerLength = TextEditingController(text: measurement?.dressLength.toString() ?? '36');

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(measurement == null ? 'Add Measurement' : 'Edit Measurement'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: controllerName, decoration: const InputDecoration(labelText: 'Profile Name')),
                const SizedBox(height: 12),
                TextField(controller: controllerShoulder, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Shoulder')),
                TextField(controller: controllerChest, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Chest')),
                TextField(controller: controllerWaist, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Waist')),
                TextField(controller: controllerHip, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Hip')),
                TextField(controller: controllerSleeve, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Sleeve Length')),
                TextField(controller: controllerLength, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Dress Length')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancel')),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result != true) return;

    final next = MeasurementModel(
      id: measurement?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      profileName: controllerName.text.trim().isEmpty ? 'My Profile' : controllerName.text.trim(),
      shoulder: double.tryParse(controllerShoulder.text) ?? 16,
      chest: double.tryParse(controllerChest.text) ?? 32,
      waist: double.tryParse(controllerWaist.text) ?? 28,
      hip: double.tryParse(controllerHip.text) ?? 34,
      sleeveLength: double.tryParse(controllerSleeve.text) ?? 18,
      dressLength: double.tryParse(controllerLength.text) ?? 36,
    );

    if (measurement == null) {
      ref.read(measurementProvider.notifier).addMeasurement(next);
    } else {
      ref.read(measurementProvider.notifier).updateMeasurement(next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final measurements = ref.watch(measurementProvider);
    final displayMeasurements = measurements.isEmpty
        ? [
            const MeasurementModel(
              id: 'initial-1',
              profileName: 'My Regular Size',
              shoulder: 16,
              chest: 32,
              waist: 28,
              hip: 34,
              sleeveLength: 18,
              dressLength: 36,
            ),
            const MeasurementModel(
              id: 'initial-2',
              profileName: 'Festive Fit',
              shoulder: 17,
              chest: 34,
              waist: 30,
              hip: 36,
              sleeveLength: 19,
              dressLength: 38,
            ),
          ]
        : measurements;

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Measurements')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: displayMeasurements.length,
                  itemBuilder: (context, index) {
                    final profile = displayMeasurements[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profile.profileName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 10, runSpacing: 8,
                            children: [
                              _StatChip(label: 'Shoulder', value: profile.shoulder.toStringAsFixed(0)),
                              _StatChip(label: 'Chest', value: profile.chest.toStringAsFixed(0)),
                              _StatChip(label: 'Waist', value: profile.waist.toStringAsFixed(0)),
                              _StatChip(label: 'Hip', value: profile.hip.toStringAsFixed(0)),
                              _StatChip(label: 'Sleeve', value: profile.sleeveLength.toStringAsFixed(0)),
                              _StatChip(label: 'Length', value: profile.dressLength.toStringAsFixed(0)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              TextButton.icon(onPressed: () => _openEditor(measurement: profile), icon: const Icon(Icons.edit), label: const Text('Edit')),
                              TextButton.icon(onPressed: () => ref.read(measurementProvider.notifier).removeMeasurement(profile.id), icon: const Icon(Icons.delete_outline_rounded), label: const Text('Delete')),
                              const Spacer(),
                              FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${profile.profileName} selected for your next dress'))), style: FilledButton.styleFrom(backgroundColor: AppTheme.plum), child: const Text('Use This Measurement')),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _openEditor(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Measurement'),
                  style: FilledButton.styleFrom(backgroundColor: AppTheme.plum, padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.blush,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text('$label: $value', style: const TextStyle(color: AppTheme.plum, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }
}
