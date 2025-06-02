import 'package:flutter/material.dart';
import 'recover_password_dialog.dart';
import 'package:frontend/screens/home_page.dart';

class LoginForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFF3498DB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.factory, color: Colors.white, size: 40),
        ),
        SizedBox(height: 20),

        Text(
          'ProducApp',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 50),

        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Correo electrónico',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 15),

        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 25),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              //Logica
              String email = _emailController.text;
              String password = _passwordController.text;
              String userRole = 'admin';

              if (email.isNotEmpty && password.isNotEmpty) {
                print(email);
                print(password);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(userRole: userRole),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Complete todos los campos')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3498DB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Iniciar sesión',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        SizedBox(height: 20),

        TextButton(
          onPressed: () => mostrarRecuperarContrasena(context),
          child: Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(color: Color(0xFF3498DB)),
          ),
        ),
      ],
    );
  }
}
