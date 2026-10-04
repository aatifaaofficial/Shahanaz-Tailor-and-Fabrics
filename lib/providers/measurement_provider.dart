import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/measurement_model.dart';

final measurementProvider = StateNotifierProvider<MeasurementNotifier, List<MeasurementModel>>((ref) {
  return MeasurementNotifier();
});

class MeasurementNotifier extends StateNotifier<List<MeasurementModel>> {
  MeasurementNotifier() : super(const []);

  void addMeasurement(MeasurementModel measurement) {
    state = [...state, measurement];
  }

  void removeMeasurement(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void updateMeasurement(MeasurementModel measurement) {
    state = [
      for (final item in state)
        if (item.id == measurement.id) measurement else item,
    ];
  }
}
