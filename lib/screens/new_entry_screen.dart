import 'package:flutter/material.dart';
import 'package:geodiary/models/journal_entry.dart';
import 'package:geodiary/services/firebase_service.dart';
import 'package:geodiary/services/location_service.dart';
import 'package:geodiary/services/notification_service.dart';
import 'package:geolocator/geolocator.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final _textController = TextEditingController();
  final _locationService = LocationService();
  final _firebaseService = FirebaseService();
  final _notificationService = NotificationService();

  Position? _currentPosition;
  String _statusMessage = 'Fetching location...';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialLocation();
    _firebaseService.logScreenView('NewEntryScreen');
  }

  Future<void> _fetchInitialLocation() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Fetching location...';
    });
    try {
      _currentPosition = await _locationService.getCurrentLocation();
      setState(() {
        if (_currentPosition != null) {
          _statusMessage =
              'Location: Lat: ${_currentPosition!.latitude.toStringAsFixed(4)}, Lon: ${_currentPosition!.longitude.toStringAsFixed(4)}';
        } else {
          _statusMessage = 'Could not fetch location.';
        }
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error fetching location: ${e.toString()}';
      });
      print("Location fetch error: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveEntry() async {
    if (_textController.text.trim().isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Please enter some text for your entry.')),
       );
       return;
    }
    if (_currentPosition == null) {
       ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Location not available. Cannot save entry.')),
       );
       return;
    }


    setState(() {
      _isLoading = true;
    });

    final newEntry = JournalEntry(
      id: '',
      text: _textController.text.trim(),
      timestamp: DateTime.now(),
      latitude: _currentPosition!.latitude,
      longitude: _currentPosition!.longitude,
    );

    try {
      await _firebaseService.saveEntry(newEntry);
      await _notificationService.showNotification(
        DateTime.now().millisecondsSinceEpoch.remainder(100000),
        'Entry Saved',
        'Your journal entry was successfully saved',
      );
       if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Entry saved successfully')),
         );
         Navigator.of(context).pop();
       }
    } catch (e) {
       if (mounted){
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text('Failed to save entry: ${e.toString()}')),
         );
       }
    } finally {
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Journal Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                 _statusMessage,
                 style: Theme.of(context).textTheme.bodySmall,
               ),
              const SizedBox(height: 16),

              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Write your journal entry here...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 8,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _isLoading || _currentPosition == null ? null : _saveEntry,
                icon: _isLoading
                    ? Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(2.0),
                        child: const CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
                      )
                    : const Icon(Icons.save),
                label: const Text('Save Entry'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}