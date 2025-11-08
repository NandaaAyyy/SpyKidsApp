import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../models/kehadiran.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = StorageService.getHistory();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Siswa'),
        backgroundColor: const Color(0xFF2F80ED),
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: items.isEmpty
          ? const Center(child: Text('Belum ada riwayat. Tekan "Perbarui Status" di Dashboard untuk menambahkan.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final KehadiranItem it = items[i];
                final status = it.status;
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
                  title: Text(it.date, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(status),
                  leading: Icon(icon, color: color),
                );
              },
            ),
    );
  }
}
