import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peta Lokasi Anak"),
        backgroundColor: const Color(0xFF2F80ED),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Lokasi Terakhir Anak",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueAccent.withOpacity(0.4)),
              ),
              child: const Center(
                child: Icon(
                  Icons.location_on,
                  size: 64,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Posisi anak berada di sekitar SDN Pakong 1.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Memperbarui lokasi...")),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Perbarui Lokasi"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F80ED),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(Icons.access_time, color: Color(0xFF2F80ED)),
                title: Text("Terakhir diperbarui"),
                subtitle: Text("Pukul 09:20 WIB"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
