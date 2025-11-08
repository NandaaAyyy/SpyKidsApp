import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF2F80ED);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Orang Tua"),
        backgroundColor: primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/images/kim.jpeg'),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Bu Siti Aminah",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Orang Tua / Wali Murid",
                    style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),

          const SizedBox(height: 26),

          const Text("Informasi Anak",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),

          _infoTile(Icons.child_care, "Nama Anak", "Nanda Ayu Primadiani"),
          _infoTile(Icons.school, "Sekolah", "SDN Pakong 1"),
          _infoTile(Icons.class_, "Kelas", "5A"),

          const SizedBox(height: 26),

          const Text("Akun",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),

          _infoTile(Icons.person, "Username", "ortu"),
          _infoTile(Icons.phone, "No. Telepon", "+62 812-3456-7890"),

          const SizedBox(height: 26),

          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Tidak bisa mengedit profil!")),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text("Edit Profil"),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),

          const SizedBox(height: 14),

          OutlinedButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            },
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text("Logout",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF2F80ED)),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
