import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
  // 🗓️ Daftar kehadiran dibuat manual
  final items = [
    {'date': '2025-10-01', 'status': 'Hadir'},
    {'date': '2025-10-02', 'status': 'Sakit'},
    {'date': '2025-10-03', 'status': 'Hadir'},
    {'date': '2025-10-04', 'status': 'Izin'},
    {'date': '2025-10-05', 'status': 'Hadir'},
    {'date': '2025-10-06', 'status': 'Hadir'},
    {'date': '2025-10-07', 'status': 'Sakit'},
  ];

  return Scaffold(
    appBar: AppBar(
      title: const Text('Riwayat Kehadiran'),
      backgroundColor: const Color(0xFF2F80ED),
    ),
    backgroundColor: const Color(0xFFF5F6FA),
    body: ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final it = items[i];
        final status = it['status']!;
        final color = status == 'Hadir'
            ? Colors.green
            : status == 'Sakit'
                ? Colors.orange
                : Colors.blue;

        final icon = status == 'Hadir'
            ? Icons.check_circle
            : status == 'Sakit'
                ? Icons.medication
                : Icons.info;

        return ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(it['date']!, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(status),
          leading: Icon(icon, color: color),
        );
      },
    ),
  );
}

}
