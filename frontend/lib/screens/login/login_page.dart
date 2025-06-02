import 'package:flutter/material.dart';
import 'package:frontend/widgets/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsets.all(20), child: LoginForm()),
    );
  }
}
