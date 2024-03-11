import 'package:flutter/material.dart';
import 'package:project_edukasi/splash_screen.dart'; // Ganti dengan lokasi file splash_screen.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Edukasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Mengarah ke SplashScreen sebagai halaman awal
    );
  }
}
