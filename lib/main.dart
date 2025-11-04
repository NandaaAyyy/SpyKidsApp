import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/dashboard_guru.dart';
import 'pages/ortu_dashboard.dart';

void main() {
  runApp(const SpyKidsApp());
}

class SpyKidsApp extends StatelessWidget {
  const SpyKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduTrack UTS Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F80ED)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (c) => const LoginPage(),
        '/guru': (c) => const GuruDashboard(),
        '/ortu': (c) => const OrtuDashboard(),
      },
    );
  }
}
