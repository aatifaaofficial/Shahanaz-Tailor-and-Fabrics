import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/app_text_field.dart';
import '../../widgets/custom_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: 'Jyoti');
    final emailController = TextEditingController(text: 'jyoti@example.com');
    final phoneController = TextEditingController(text: '+91 98765 43210');

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80'),
              ),
              const SizedBox(height: 20),
              AppTextField(controller: nameController, label: 'Name', prefixIcon: Icons.person_outline),
              const SizedBox(height: 16),
              AppTextField(controller: emailController, label: 'Email', prefixIcon: Icons.email_outlined),
              const SizedBox(height: 16),
              AppTextField(controller: phoneController, label: 'Phone', prefixIcon: Icons.phone_outlined),
              const SizedBox(height: 20),
              CustomButton(
                label: 'Save Changes',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
