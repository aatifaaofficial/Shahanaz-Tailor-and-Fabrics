import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/notification_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(18),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: notification.isRead ? Colors.white : const Color(0xFFFCECF0),
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(child: Icon(Icons.notifications_none_rounded)),
                title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text(notification.message),
                trailing: Text(notification.time, style: const TextStyle(fontSize: 12)),
              ),
            );
          },
        ),
      ),
    );
  }
}
