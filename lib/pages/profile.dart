import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Orang Tua'), backgroundColor: const Color(0xFF2F80ED)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 46,
              backgroundColor: Color(0xFFEEF7FF),
              child: Icon(Icons.person, size: 40, color: Color(0xFF2F80ED)),
            ),
            const SizedBox(height: 12),
            const Text('Nama: Rizki Ahmad', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Hubungan: Ayah'),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2F80ED)),
            ),
          ],
        ),
      ),
    );
  }
}
