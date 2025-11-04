import 'package:flutter/material.dart';
import '../shared.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF2F80ED);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EduTrack — Dashboard'),
        backgroundColor: primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: SharedState.instance.student,
              builder: (context, Student s, _) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFEAF1FF),
                      child: Icon(Icons.child_care, color: Color(0xFF2F80ED)),
                    ),
                    title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${s.school} • Kelas ${s.kelas}'),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(s.status, style: TextStyle(color: _statusColor(s.status), fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text('Terakhir: ${s.lastUpdate}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            // Simple action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/attendance'),
                    icon: const Icon(Icons.how_to_reg),
                    label: const Text('Kehadiran'),
                    style: ElevatedButton.styleFrom(backgroundColor: primary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/profile'),
                    icon: const Icon(Icons.person),
                    label: const Text('Profil'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Info singkat / instruksi
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: const [
                    Text('Instruksi untuk UAS', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('1. Buka menu "Kehadiran" untuk melihat/tandai status siswa (sebagai Guru).'),
                    Text('2. Kembali ke Dashboard untuk melihat update status.'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Text('EduTrack — Demo UAS', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  static Color _statusColor(String s) {
    if (s == 'Di Sekolah') return Colors.green;
    if (s == 'Dalam Perjalanan') return Colors.orange;
    if (s == 'Sudah di Rumah') return Colors.blue;
    return Colors.black54;
  }
}
