import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'map.dart';
import 'history.dart';


class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _idx = 0;
  final _pages = const [DashboardPage(), MapPage(), HistoryPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _idx,
        selectedItemColor: const Color(0xFF2F80ED),
        unselectedItemColor: Colors.grey.shade600,
        onTap: (i) => setState(() => _idx = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Lokasi'),
          BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: 'Riwayat'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/profile'),
        backgroundColor: const Color(0xFF2F80ED),
        child: const Icon(Icons.person),
      ),
    );
  }
}
