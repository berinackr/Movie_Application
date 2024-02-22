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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromRGBO(36, 42, 50, 1),
        useMaterial3: true,
      
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Uygulama başlangıç ekranı olarak SplashScreen kullanılıyor
    );
  }
}
