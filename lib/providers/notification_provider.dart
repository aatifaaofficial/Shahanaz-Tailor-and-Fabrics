import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/demo_data.dart';
import '../models/notification_model.dart';

final notificationProvider = StateNotifierProvider<NotificationNotifier, List<NotificationModel>>((ref) {
  return NotificationNotifier();
});

class NotificationNotifier extends StateNotifier<List<NotificationModel>> {
  NotificationNotifier() : super(DemoData.notifications);

  void markAsRead(String id) {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(isRead: true) else item,
    ];
  }
}
