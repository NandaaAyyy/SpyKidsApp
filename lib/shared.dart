import 'package:flutter/material.dart';

class Student {
  String name;
  String school;
  String kelas;
  String status; // Di Sekolah / Dalam Perjalanan / Sudah di Rumah
  String lastUpdate;

  Student({
    required this.name,
    required this.school,
    required this.kelas,
    required this.status,
    required this.lastUpdate,
  });
}

class SharedState {
  // Singleton pattern
  SharedState._internal();
  static final SharedState instance = SharedState._internal();

  // Notifier agar UI otomatis update ketika data berubah
  final ValueNotifier<Student> student = ValueNotifier<Student>(
    Student(
      name: 'Nanda Ayu Primadiani',
      school: 'SDN Pakong 1',
      kelas: '5A',
      status: 'Di Sekolah',
      lastUpdate: _formatTime(DateTime.now()),
    ),
  );

  static String _formatTime(DateTime t) =>
      "${t.hour.toString().padLeft(2,'0')}:${t.minute.toString().padLeft(2,'0')}";

  void updateStatus(String newStatus) {
    final s = student.value;
    s.status = newStatus;
    s.lastUpdate = _formatTime(DateTime.now());
    student.value = s; // trigger listeners
  }
}
