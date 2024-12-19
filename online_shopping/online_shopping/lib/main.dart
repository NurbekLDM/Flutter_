import 'package:flutter/material.dart';
import './pages/HomePage.dart';
import './pages/AdminLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Shop',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Change the primary color to blueGrey
        colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.orange), // Keep the secondary color as orange
        visualDensity: VisualDensity.adaptivePlatformDensity, // Keep the adaptive platform density
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Colors.white),
        ), 
      ),
      home: AdminLoginPage(), 
      debugShowCheckedModeBanner: false, 
    );
  }
}