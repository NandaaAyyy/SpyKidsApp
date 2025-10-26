import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String status = 'Di Sekolah';
  String lastUpdate = '08:00';
  int attendanceScore = 98;

  void _toggleStatus() {
    setState(() {
      if (status == 'Di Sekolah') {
        status = 'Dalam Perjalanan';
      } else if (status == 'Dalam Perjalanan') {
        status = 'Sudah di Rumah';
      } else {
        status = 'Di Sekolah';
      }
      lastUpdate = TimeOfDay.now().format(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = const Color(0xFF2F80ED);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Dashboard'), backgroundColor: color),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: color.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(12)),
                  child:
                      const Icon(Icons.child_care, size: 36, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                const Text('Nanda Ayu Primadiani',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 18),
            Card(
              child: ListTile(
                leading: Icon(_statusIcon(status), color: _statusColor(status)),
                title: Text(status,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _statusColor(status))),
                subtitle: Text('Terakhir diperbarui: $lastUpdate'),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _toggleStatus,
              icon: const Icon(Icons.sync),
              label: const Text('Perbarui Status'),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: const Text('Kehadiran'),
                subtitle: Text('$attendanceScore% bulan ini'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _statusIcon(String s) {
    if (s == 'Di Sekolah') return Icons.school;
    if (s == 'Dalam Perjalanan') return Icons.directions_bus;
    return Icons.home;
  }

  Color _statusColor(String s) {
    if (s == 'Di Sekolah') return Colors.green;
    if (s == 'Dalam Perjalanan') return Colors.orange;
    return Colors.blue;
  }
}
