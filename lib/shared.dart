import 'package:flutter/material.dart';

class StudentStatus {
  String status;
  String lastUpdate;
  int attendanceScore;
  String kelas;
  String nama;
  String sekolah;

  StudentStatus({
    required this.status,
    required this.lastUpdate,
    required this.attendanceScore,
    required this.nama,
    required this.sekolah,
    required this.kelas,
  });

  Map<String, dynamic> toMap() => {
        'status': status,
        'lastUpdate': lastUpdate,
        'attendanceScore': attendanceScore,
        'nama': nama,
        'sekolah': sekolah,
        'kelas': kelas,
      };
}

class SharedState {
  // ValueNotifier supaya UI bisa listen secara realtime
  final ValueNotifier<StudentStatus> notifier;

  SharedState._internal(this.notifier);

  // Inisialisasi default (isi dengan data yang kamu berikan)
  static final SharedState instance = SharedState._internal(
    ValueNotifier<StudentStatus>(
      StudentStatus(
        status: 'Di Sekolah',
        lastUpdate: _formatTime(DateTime.now()),
        attendanceScore: 98,
        nama: 'Nanda Ayu Primadiani',
        sekolah: 'SDN Pakong 1',
        kelas: '5A',
      ),
    ),
  );

  static String _formatTime(DateTime t) =>
      "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

  // Update status (dipanggil oleh Guru)
  void updateStatus(String newStatus) {
    final s = notifier.value;
    s.status = newStatus;
    s.lastUpdate = _formatTime(DateTime.now());
    notifier.value = s; // trigger notifier listeners
  }

  // Update attendance score (opsional)
  void updateAttendance(int newScore) {
    final s = notifier.value;
    s.attendanceScore = newScore;
    notifier.value = s;
  }
}
