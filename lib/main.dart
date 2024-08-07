import 'package:flutter/material.dart';
import 'student_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Records',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Primary color
          secondary: Colors.blue, // Accent color
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue, // Default button color
          textTheme: ButtonTextTheme.primary,
        ),
        cardColor: Colors.white,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          color: Colors.blue, // AppBar color
          titleTextStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: StudentListPage(),
    );
  }
}
