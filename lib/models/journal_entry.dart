import 'package:intl/intl.dart';

class JournalEntry {
  final String id;
  final String text;
  final DateTime timestamp;
  final double latitude;
  final double longitude;

  JournalEntry({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
  });

  String get formattedTimestamp {
    return DateFormat('yyyy-MM-dd – kk:mm').format(timestamp);
  }

  factory JournalEntry.fromMap(String id, Map<dynamic, dynamic> data) {
    return JournalEntry(
      id: id,
      text: data['text'] ?? 'No Text',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp'] ?? 0),
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}