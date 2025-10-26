import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lokasi Anak'), backgroundColor: const Color(0xFF2F80ED)),
      body: const Center(
        child: Icon(Icons.map, size: 100, color: Colors.blueAccent),
      ),
    );
  }
}
