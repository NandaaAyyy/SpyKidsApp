import 'package:flutter/material.dart';
import '../services/location_service.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Position? _pos;
  bool _loading = false;

  Future<void> _fetchLocation() async {
    setState(() => _loading = true);
    final p = await LocationService.getCurrentPosition();
    setState(() {
      _pos = p;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

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
              child: Center(
                child: _loading
                    ? const CircularProgressIndicator()
                    : _pos == null
                        ? const Text("Lokasi tidak tersedia. Aktifkan permission.")
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.location_on, size: 64, color: Colors.red),
                              const SizedBox(height: 8),
                              Text("Lat: ${_pos!.latitude.toStringAsFixed(6)}"),
                              Text("Lng: ${_pos!.longitude.toStringAsFixed(6)}"),
                            ],
                          ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Posisi ditentukan oleh perangkat ini (demo).",
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _fetchLocation,
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
                subtitle: Text("—"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
