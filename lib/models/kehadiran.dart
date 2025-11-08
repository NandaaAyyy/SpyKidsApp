class KehadiranItem {
  final String date;
  final String status;

  KehadiranItem({required this.date, required this.status});

  Map<String, dynamic> toJson() => {'date': date, 'status': status};

  factory KehadiranItem.fromJson(Map<String, dynamic> j) =>
      KehadiranItem(date: j['date'] as String, status: j['status'] as String);
}
