import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pongas_ativ/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Erro ao inicializar o Firebase: $e");
  }

  runApp(const PongasApp());
}

class PongasApp extends StatelessWidget {
  const PongasApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definindo as cores
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color accentRed = Color(0xFFFF1919);
    const Color backgroundLight = Color(0xFFF2F2F2);

    return MaterialApp(
      title: 'Pongas App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryBlue,
        scaffoldBackgroundColor: backgroundLight,
        colorScheme: const ColorScheme.light(
          primary: primaryBlue,
          secondary: accentRed,
          background: backgroundLight,
          surface: Colors.white,
          onBackground: Colors.black87,
        ),

        // ... (Restante do seu ThemeData)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentRed,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15.0),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: accentRed, width: 2.0),
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
        ),
        useMaterial3: true,
      ),

      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
