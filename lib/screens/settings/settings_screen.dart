import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SwitchListTile(title: const Text('Notifications'), value: notifications, onChanged: (value) => setState(() => notifications = value)),
            SwitchListTile(title: const Text('Dark Mode'), value: darkMode, onChanged: (value) => setState(() => darkMode = value)),
            ListTile(title: const Text('Language'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Language settings coming soon')))),
            ListTile(title: const Text('Privacy'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Privacy settings loaded')))),
            ListTile(title: const Text('Terms & Conditions'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Terms and conditions opened')))),
            ListTile(title: const Text('Help & Support'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () => context.push('/help')),
            ListTile(title: const Text('About App'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () => context.push('/about')),
            ListTile(title: const Text('Logout'), trailing: const Icon(Icons.logout_rounded), onTap: () => context.go('/login')),
          ],
        ),
      ),
    );
  }
}
