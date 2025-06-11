import 'package:flutter/material.dart';
import 'package:frontend/utils/shared_preferences_helper.dart';
import 'recover_password_dialog.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/models/login/login_request.dart';
import 'package:frontend/services/login/auth_service.dart';
import 'package:frontend/widgets/dialogs/loading_general.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo
        SizedBox(
          width: 350,
          height: 250,
          child: Image.asset(
            'assets/images/Logo.png',
            fit: BoxFit
                .contain, // O usa BoxFit.cover si quieres que llene el espacio
          ),
        ),
        SizedBox(height: 20),

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
            onPressed: () async {
              String emailFlutter = _emailController.text.trim();
              String passwordFlutter = _passwordController.text;

              if (emailFlutter.isEmpty || passwordFlutter.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Por favor ingresa correo y contraseña')),
                );
                return;
              }

              // Mostrar el diálogo de carga
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const LoadingDialog(
                    mensaje: "Estamos validando tus datos",
                    size: 50,
                  );
                },
              );

              final loginRequest = LoginRequest(
                correo: emailFlutter,
                contrasena: passwordFlutter,
              );
              final authService = AuthService();

              try {
                final response = await authService.login(loginRequest);

                if (!mounted) return;

                Navigator.of(context).pop(); // Cerrar el diálogo

                if (response != null) {
                  await SharedPreferencesHelper.saveToken(response.token);
                  await SharedPreferencesHelper.saveRol(response.rol);
                  await SharedPreferencesHelper.saveUserId(response.id);
                  final savedRol = await SharedPreferencesHelper.getRol();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(userRole: savedRol!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Correo o contraseña incorrectos.')),
                  );
                }
              } catch (e) {
                if (mounted)
                  Navigator.of(context).pop(); // Cerrar el diálogo si hay error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Error de conexión. Verifica el servidor o tu red.'),
                  ),
                );
                print('Error de conexión: $e');
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
