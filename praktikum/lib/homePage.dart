import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Selamat datang di Praktikum Mobile 1',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 27),
            ),
            SizedBox(height: 5),
            Text(
              'Universitas Islam Kalimantan Muhammad Arsyad Al Banjarmi',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
