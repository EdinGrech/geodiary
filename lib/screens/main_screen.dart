import 'package:flutter/material.dart';
import 'package:geodiary/models/journal_entry.dart';
import 'package:geodiary/screens/new_entry_screen.dart';
import 'package:geodiary/services/firebase_service.dart';
import 'package:geodiary/widgets/entry_list_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseService _firebaseService = FirebaseService();

   @override
   void initState() {
     super.initState();
     _firebaseService.logScreenView('MainScreen');
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoDiary Entries'),
      ),
      body: StreamBuilder<List<JournalEntry>>(
        stream: _firebaseService.getEntriesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print('StreamBuilder Error: ${snapshot.error}');
            return Center(child: Text('Error loading entries: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No entries yet.\nTap the + button to add one!',
                textAlign: TextAlign.center,
              ),
            );
          }

          final entries = snapshot.data!;
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (ctx, index) {
              return EntryListItem(entry: entries[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => const NewEntryScreen()),
          );
        },
        tooltip: 'Add New Entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}