import 'package:flutter/material.dart';
import '../shared.dart';

class OrtuDashboard extends StatelessWidget {
  const OrtuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF2F80ED);
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Orang Tua'), backgroundColor: primary),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: SharedState.instance.notifier,
              builder: (context, StudentStatus s, _) {
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const CircleAvatar(backgroundColor: Color(0xFFEAF1FF), child: Icon(Icons.child_care, color: Color(0xFF2F80ED))),
                    title: Text(s.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${s.sekolah} • Kelas ${s.kelas}'),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Text('Kehadiran', style: TextStyle(fontSize: 12, color: Colors.black54)), Text('${s.attendanceScore}%', style: const TextStyle(fontWeight: FontWeight.bold))],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            const Align(alignment: Alignment.centerLeft, child: Text('Status Terbaru', style: TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: SharedState.instance.notifier,
              builder: (context, StudentStatus s, _) {
                return Card(
                  child: ListTile(
                    leading: Icon(_statusIcon(s.status), color: _statusColor(s.status)),
                    title: Text(s.status, style: TextStyle(fontWeight: FontWeight.bold, color: _statusColor(s.status))),
                    subtitle: Text('Terakhir diperbarui: ${s.lastUpdate}'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            const Align(alignment: Alignment.centerLeft, child: Text('Pesan dari Guru', style: TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(height: 8),
            Card(child: ListTile(leading: const Icon(Icons.message), title: const Text('Belum ada pesan baru'), subtitle: const Text('Semua update akan tampil di sini'))),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Demo: refresh UI or show help
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data sudah realtime (lokal demo)')));
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
              style: ElevatedButton.styleFrom(backgroundColor: primary),
            ),
          ],
        ),
      ),
    );
  }

  static IconData _statusIcon(String s) {
    if (s == 'Di Sekolah') return Icons.school_rounded;
    if (s == 'Dalam Perjalanan') return Icons.directions_bus;
    if (s == 'Sudah di Rumah') return Icons.home_rounded;
    if (s == 'Izin') return Icons.event_note;
    if (s == 'Sakit') return Icons.medical_services;
    if (s == 'Alfa') return Icons.do_not_disturb_on;
    return Icons.info;
  }

  static Color _statusColor(String s) {
    if (s == 'Di Sekolah') return Colors.green;
    if (s == 'Dalam Perjalanan') return Colors.orange;
    if (s == 'Sudah di Rumah') return Colors.blue;
    if (s == 'Izin') return Colors.purple;
    if (s == 'Sakit') return Colors.red;
    if (s == 'Alfa') return Colors.grey;
    return Colors.black;
  }
}
