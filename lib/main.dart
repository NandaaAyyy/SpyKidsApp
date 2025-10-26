import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/home.dart';
import 'pages/profile.dart';
import 'pages/map.dart';
import 'pages/history.dart';
import 'pages/shell.dart';

void main() {
  runApp(const SpyKidsApp());
}

class SpyKidsApp extends StatelessWidget {
  const SpyKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spy Kids ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3399FF)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (c) => const LoginPage(),
        '/home': (c) => const HomeShell(),
        '/profile': (c) => const ProfilePage(),
        '/map': (c) => const MapPage(),
        '/history': (c) => const HistoryPage(),
      },
    );
  }
}
