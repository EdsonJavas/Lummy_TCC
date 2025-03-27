// main.dart
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(Lummy());
}

class Lummy extends StatelessWidget {
  const Lummy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lummy',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(bodyMedium: TextStyle(fontFamily: 'Poppins')),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false, // Removendo o banner de debug
      home: MyHomePage(
        title: 'Lummy',
      ), // Passando o título para a página MyHomePage
    );
  }
}
