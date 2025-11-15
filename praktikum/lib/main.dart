import 'package:flutter/material.dart';
import 'package:praktikum/navigationBar.dart'; // Pastikan path ini sesuai

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainNavigator(), // <-- Ganti ke sini
    );
  }
}
