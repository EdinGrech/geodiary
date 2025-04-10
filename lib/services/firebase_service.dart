import 'package:firebase_database/firebase_database.dart';
import 'package:geodiary/models/journal_entry.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseService {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('entries');
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> saveEntry(JournalEntry entry) async {
    try {
      await _databaseRef.push().set(entry.toMap());
      await _analytics.logEvent(
        name: 'entry_saved',
        parameters: <String, Object>{
          'text_length': entry.text.length as Object,
          'latitude': entry.latitude as Object,
          'longitude': entry.longitude as Object,
        },
      );
    } catch (e) {
      print("Error saving entry: $e");
       await _analytics.logEvent(name: 'save_entry_error', parameters: {'error': e.toString()});
      rethrow;
    }
  }

  Stream<List<JournalEntry>> getEntriesStream() {
    return _databaseRef.onValue.map((event) {
      final List<JournalEntry> entries = [];
      final dynamic snapshotValue = event.snapshot.value;

      if (snapshotValue != null && snapshotValue is Map) {
         final Map<dynamic, dynamic> entriesMap = Map<dynamic, dynamic>.from(snapshotValue);
        entriesMap.forEach((key, value) {
          if (value != null && value is Map) {
            entries.add(JournalEntry.fromMap(key, Map<dynamic, dynamic>.from(value)));
          }
        });
        entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      }
      return entries;
    });
  }

   Future<void> logScreenView(String screenName) async {
     await _analytics.logScreenView(screenName: screenName);
   }
}