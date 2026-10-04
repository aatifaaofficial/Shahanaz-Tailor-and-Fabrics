import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('My Orders', Icons.receipt_long_rounded, '/orders'),
      ('Favorites', Icons.favorite_rounded, '/favorites'),
      ('Saved Measurements', Icons.straighten_rounded, '/measurements'),
      ('Saved Addresses', Icons.location_on_outlined, '/settings'),
      ('Payment Methods', Icons.credit_card_rounded, '/settings'),
      ('Notifications', Icons.notifications_none_rounded, '/notifications'),
      ('Settings', Icons.settings_outlined, '/settings'),
      ('Help & Support', Icons.help_outline_rounded, '/help'),
      ('About Us', Icons.info_outline_rounded, '/about'),
      ('Admin Demo', Icons.admin_panel_settings_rounded, '/admin'),
      ('Logout', Icons.logout_rounded, '/login'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Jyoti', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text('jyoti@example.com', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => context.push('/edit-profile'),
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ...items.map((item) {
                final label = item.$1;
                final icon = item.$2;
                final route = item.$3;
                return ListTile(
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppTheme.blush,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: AppTheme.plum),
                  ),
                  title: Text(label),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => route == '/login' ? context.go('/login') : context.push(route),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
