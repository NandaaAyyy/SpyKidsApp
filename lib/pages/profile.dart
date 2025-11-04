import 'package:flutter/material.dart';
import '../shared.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF2F80ED);
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Siswa'), backgroundColor: primary),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ValueListenableBuilder(
          valueListenable: SharedState.instance.student,
          builder: (context, Student s, _) {
            return Column(
              children: [
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Color(0xFFEAF1FF), child: Icon(Icons.person, color: Color(0xFF2F80ED))),
                    title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${s.school} • Kelas ${s.kelas}'),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Status Saat Ini'),
                    subtitle: Text('${s.status} • Terakhir: ${s.lastUpdate}'),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text('Catatan'),
                    subtitle: const Text('Versi UTS: demo lokal tanpa backend.'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
