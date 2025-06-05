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

  void mostrarLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(),
    );

    //Cierre forzado por si se queda colgado el servidor
    Future.delayed(Duration(seconds: 5), () {
      if (!mounted) return; // Asegura que el widget sigue vivo
      final nav = Navigator.of(context, rootNavigator: true);
      if (nav.canPop()) {
        nav.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sin respuesta del servidor')),
        );
      }
    });
  }

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

              mostrarLoading(context);

              final loginRequest = LoginRequest(
                correo: emailFlutter,
                contrasena: passwordFlutter,
              );
              final authService = AuthService();

              final response = await authService.login(loginRequest);

              if (!mounted)
                return; // <-- Evita usar context si widget desmontado

              // Cerrar el loading
              Navigator.of(context).pop();

              if (response != null) {
                await SharedPreferencesHelper.saveToken(response.token);
                await SharedPreferencesHelper.saveRol(response.rol);
                print(
                    'Login exitoso, token guardado: ${response.token} y rol guardado: ${response.rol}');
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
