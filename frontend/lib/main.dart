import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_page.dart';

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
