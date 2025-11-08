import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../models/kehadiran.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}
class _DashboardPageState extends State<DashboardPage> {
  String status = 'Di Sekolah';
  String lastUpdate = _formatTime(DateTime.now());
  int attendanceScore = 98;
  bool showNotifDot = true;

  static String _formatTime(DateTime t) => "${t.hour.toString().padLeft(2,'0')}:${t.minute.toString().padLeft(2,'0')}";

  @override
  void initState() {
    super.initState();
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final s = StorageService.getStatus();
    final lu = StorageService.getLastUpdate();
    final as = StorageService.getAttendanceScore();
    setState(() {
      status = s;
      lastUpdate = lu;
      attendanceScore = as;
    });
  }

  void _toggleStatus() {
    setState(() {
      if (status == 'Di Sekolah') {
        status = 'Dalam Perjalanan';
      } else if (status == 'Dalam Perjalanan') {
        status = 'Sudah di Rumah';
      } else {
        status = 'Di Sekolah';
      }
      lastUpdate = _formatTime(DateTime.now());
      showNotifDot = true;
    });

    // simpan ke storage
    StorageService.setStatus(status);
    StorageService.setLastUpdate(lastUpdate);

    // tambah ke riwayat (hari ini)
    final today = DateTime.now();
    final date = "${today.year.toString().padLeft(4,'0')}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
    final history = StorageService.getHistory();
    history.insert(0, KehadiranItem(date: date, status: status));
    final truncated = history.take(50).toList();
    StorageService.setHistory(truncated);
  }

  @override
  Widget build(BuildContext context) {
    final color = const Color(0xFF2F80ED);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.child_care, size: 36, color: Color(0xFF2F80ED)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Nanda Ayu Primadiani', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  Text('Kelas 5A — SDN Pakong 1', style: TextStyle(color: const Color.fromARGB(255, 97, 97, 97))),
                ]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (showNotifDot) Container(width: 10, height: 10, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red)),
                  const SizedBox(height: 6),
                  Text('Terakhir: $lastUpdate', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          // status card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
            child: Row(
              children: [
                Icon(_statusIcon(status), size: 48, color: _statusColor(status)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(status, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _statusColor(status))),
                    const SizedBox(height: 6),
                    Text('Status anak Anda saat ini.', style: const TextStyle(color: Colors.black54)),
                  ]),
                )
              ],
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: _toggleStatus,
            icon: const Icon(Icons.sync),
            label: const Text('Perbarui Status'),
            style: ElevatedButton.styleFrom(backgroundColor: color, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(height: 18),

          // small metrics row
          Row(
            children: [
              _metricCard('Kehadiran', '$attendanceScore%', Icons.check_circle, Colors.green),
              const SizedBox(width: 12),
              _metricCard('Tugas', '2 belum', Icons.assignment_late, Colors.orange),
            ],
          ),
          const SizedBox(height: 18),

          // messages
          const Text('Pesan dari Guru', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person), backgroundColor: Color(0xFFEEF7FF)),
              title: const Text('Bu Siti Aminah'),
              subtitle: const Text('Anak Anda aktif hari ini pada pelajaran IPA.'),
              trailing: Text(StorageService.getLastUpdate(), style: const TextStyle(color: Colors.black54)),
            ),
          ),

          const SizedBox(height: 18),

          // quick action row
          Row(
            children: [
              Expanded(child: _quickAction(Icons.map, 'Lihat Peta', () => Navigator.pushNamed(context, '/map'))),
              const SizedBox(width: 12),
              Expanded(child: _quickAction(Icons.history, 'Riwayat', () => Navigator.pushNamed(context, '/history'))),
            ],
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _metricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.12), child: Icon(icon, color: color)),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)), Text(value, style: const TextStyle(fontWeight: FontWeight.bold))]),
          ],
        ),
      ),
    );
  }

  Widget _quickAction(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)]),
        child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: const Color(0xFF2F80ED)), const SizedBox(height: 6), Text(label, style: const TextStyle(fontWeight: FontWeight.w600))]),
      ),
    );
  }

  static IconData _statusIcon(String s) {
    if (s == 'Di Sekolah') return Icons.school_rounded;
    if (s == 'Dalam Perjalanan') return Icons.directions_bus;
    return Icons.home_rounded;
  }
  static Color _statusColor(String s) {
    if (s == 'Di Sekolah') return Colors.green;
    if (s == 'Dalam Perjalanan') return Colors.orange;
    return Colors.blue;
  }
}
