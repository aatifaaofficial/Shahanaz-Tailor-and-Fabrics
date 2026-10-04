import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/custom_dress_model.dart';

final customizationProvider = StateNotifierProvider<CustomizationNotifier, CustomDressModel?>((ref) {
  return CustomizationNotifier();
});

class CustomizationNotifier extends StateNotifier<CustomDressModel?> {
  CustomizationNotifier() : super(null);

  void update(CustomDressModel dress) {
    state = dress;
  }

  void clear() {
    state = null;
  }
}
