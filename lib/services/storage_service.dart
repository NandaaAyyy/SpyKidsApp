import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/kehadiran.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static const _keyStatus = 'child_status';
  static const _keyLastUpdate = 'last_update';
  static const _keyAttendance = 'attendance_score';
  static const _keyHistory = 'attendance_history';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // status
  static String getStatus() => _prefs.getString(_keyStatus) ?? 'Di Sekolah';
  static Future<void> setStatus(String v) async => _prefs.setString(_keyStatus, v);

  // last update
  static String getLastUpdate() => _prefs.getString(_keyLastUpdate) ?? _formatNow();
  static Future<void> setLastUpdate(String v) async => _prefs.setString(_keyLastUpdate, v);

  // attendance score
  static int getAttendanceScore() => _prefs.getInt(_keyAttendance) ?? 98;
  static Future<void> setAttendanceScore(int v) async => _prefs.setInt(_keyAttendance, v);

  // history (list of AttendanceItem)
  static List<KehadiranItem> getHistory() {
    final raw = _prefs.getString(_keyHistory);
    if (raw == null) return [];
    try {
      final arr = jsonDecode(raw) as List<dynamic>;
      return arr.map((e) => KehadiranItem.fromJson(Map<String, dynamic>.from(e))).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> setHistory(List<KehadiranItem> items) async {
    final raw = jsonEncode(items.map((e) => e.toJson()).toList());
    await _prefs.setString(_keyHistory, raw);
  }

  static String _formatNow() {
    final t = DateTime.now();
    return "${t.hour.toString().padLeft(2,'0')}:${t.minute.toString().padLeft(2,'0')}";
  }
}
