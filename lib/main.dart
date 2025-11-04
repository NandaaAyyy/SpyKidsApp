import 'package:flutter/material.dart';
import 'pages/dashboard.dart';
import 'pages/kehadiran.dart';
import 'pages/profile.dart';

void main() {
  runApp(const SpyKidsApp());
}

class SpyKidsApp extends StatelessWidget {
  const SpyKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spy Kids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2F80ED),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F80ED)),
        scaffoldBackgroundColor: const Color(0xFFF6F9FF),
      ),
      initialRoute: '/',
      routes: {
        '/': (c) => const DashboardPage(),
        '/attendance': (c) => const AttendancePage(),
        '/profile': (c) => const ProfilePage(),
      },
    );
  }
}
