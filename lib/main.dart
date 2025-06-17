// main.dart
import 'package:flutter/material.dart';
import 'package:lummy_login/login_page.dart';

void main() {
  runApp(const LummyApp());
}

class LummyApp extends StatelessWidget {
  const LummyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lummy Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}