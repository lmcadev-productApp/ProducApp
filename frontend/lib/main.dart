import 'package:flutter/material.dart';
import 'package:frontend/screens/login_page.dart'; // Asegúrate que la ruta y nombre sean correctos

void main() {
  runApp(ProducApp());
}

class ProducApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
