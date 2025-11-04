import 'package:flutter/material.dart';
import '../shared.dart';

class GuruDashboard extends StatefulWidget {
  const GuruDashboard({super.key});
  @override
  State<GuruDashboard> createState() => _GuruDashboardState();
}

class _GuruDashboardState extends State<GuruDashboard> {
  String selectedStatus = 'Di Sekolah';
  final _statuses = ['Di Sekolah', 'Dalam Perjalanan', 'Sudah di Rumah', 'Izin', 'Sakit', 'Alfa'];
  final attendanceCtrl = TextEditingController();

  void _sendUpdate() {
    SharedState.instance.updateStatus(selectedStatus);
    if (attendanceCtrl.text.isNotEmpty) {
      final v = int.tryParse(attendanceCtrl.text);
      if (v != null) SharedState.instance.updateAttendance(v.clamp(0, 100));
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Update terkirim')));
  }

  @override
  void dispose() {
    attendanceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = SharedState.instance.notifier.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Guru'),
        backgroundColor: const Color(0xFF2F80ED),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.child_care, color: Color(0xFF2F80ED)),
                title: Text(s.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${s.sekolah} • Kelas ${s.kelas}'),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pilih Status Kehadiran', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      items: _statuses.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) => setState(() => selectedStatus = v ?? selectedStatus),
                    ),
                    const SizedBox(height: 12),
                    const Text('Update Nilai Kehadiran (opsional, 0-100)'),
                    const SizedBox(height: 6),
                    TextField(controller: attendanceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: '98')),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _sendUpdate,
                            icon: const Icon(Icons.send),
                            label: const Text('Kirim Update'),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2F80ED)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Preview status saat ini:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: SharedState.instance.notifier,
              builder: (context, StudentStatus s, _) {
                return Card(
                  child: ListTile(
                    leading: Icon(_statusIcon(s.status), color: _statusColor(s.status)),
                    title: Text(s.status, style: TextStyle(fontWeight: FontWeight.bold, color: _statusColor(s.status))),
                    subtitle: Text('Terakhir: ${s.lastUpdate} • Kehadiran: ${s.attendanceScore}%'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static IconData _statusIcon(String s) {
    if (s == 'Di Sekolah') return Icons.school;
    if (s == 'Dalam Perjalanan') return Icons.directions_bus;
    if (s == 'Sudah di Rumah') return Icons.home;
    return Icons.info;
  }

  static Color _statusColor(String s) {
    if (s == 'Di Sekolah') return Colors.green;
    if (s == 'Dalam Perjalanan') return Colors.orange;
    if (s == 'Sudah di Rumah') return Colors.blue;
    return Colors.grey;
  }
}
