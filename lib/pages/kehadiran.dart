import 'package:flutter/material.dart';
import '../shared.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String selected = 'Di Sekolah';
  final statuses = ['Di Sekolah', 'Dalam Perjalanan', 'Sudah di Rumah', 'Izin', 'Sakit', 'Alfa'];

  void _submit() {
    SharedState.instance.updateStatus(selected);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Status berhasil diperbarui')));
  }

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF2F80ED);

    return Scaffold(
      appBar: AppBar(title: const Text('Kehadiran (Guru)'), backgroundColor: primary),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pilih status kehadiran', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selected,
                      items: statuses.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) => setState(() => selected = v ?? selected),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _submit,
                            icon: const Icon(Icons.send),
                            label: const Text('Kirim'),
                            style: ElevatedButton.styleFrom(backgroundColor: primary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Preview status saat ini:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: SharedState.instance.student,
              builder: (context, Student s, _) {
                return ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  leading: Icon(Icons.info, color: _statusColor(s.status)),
                  title: Text(s.status, style: TextStyle(fontWeight: FontWeight.bold, color: _statusColor(s.status))),
                  subtitle: Text('Terakhir: ${s.lastUpdate}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static Color _statusColor(String s) {
    if (s == 'Di Sekolah') return Colors.green;
    if (s == 'Dalam Perjalanan') return Colors.orange;
    if (s == 'Sudah di Rumah') return Colors.blue;
    if (s == 'Izin') return Colors.purple;
    if (s == 'Sakit') return Colors.red;
    return Colors.grey;
  }
}
