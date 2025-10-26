import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(7, (i) => {'date': '2025-10-${i + 1}', 'status': i % 2 == 0 ? 'Hadir' : 'Sakit'});
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Kehadiran'), backgroundColor: const Color(0xFF2F80ED)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final it = items[i];
          return ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(it['date']!),
            subtitle: Text(it['status']!),
            leading: Icon(
              it['status'] == 'Hadir' ? Icons.check_circle : Icons.medication,
              color: it['status'] == 'Hadir' ? Colors.green : Colors.orange,
            ),
          );
        },
      ),
    );
  }
}
