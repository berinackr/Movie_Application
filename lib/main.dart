import 'package:flutter/material.dart';
import 'package:movie_application/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Uygulama başlangıç ekranı olarak SplashScreen kullanılıyor
    );
  }
}
