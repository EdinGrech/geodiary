import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geodiary/screens/main_screen.dart';
import 'package:geodiary/services/notification_service.dart';
import 'utils/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.teal,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFF9F9F9),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.teal,
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
  ),
  textTheme: GoogleFonts.nunitoTextTheme().copyWith(
    headlineLarge: GoogleFonts.nunito(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    titleMedium: GoogleFonts.nunito(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: 16,
      color: Colors.black87,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.teal),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.teal, width: 2),
    ),
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),
);



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().init();

  runApp(const GeoDiaryApp());
}

class GeoDiaryApp extends StatelessWidget {
  const GeoDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoDiary',
      theme: theme,
      home: const MainScreen(),
    );
  }
}