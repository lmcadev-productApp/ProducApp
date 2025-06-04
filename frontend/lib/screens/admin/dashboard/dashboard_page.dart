import 'package:flutter/material.dart';
import 'package:frontend/utils/shared_preferences_helper.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/screens/login/login_page.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    // Contenido de la pantalla
    Widget contenidoPantalla = const Center(
      child: Text(
        '¡Hola, ProducApp!',
        style: TextStyle(fontSize: 20),
      ),
    );

    // Widget reutilizable
    return BaseScreen(
      titulo: 'DashBoard',
      mostrarLogout: true,
      mostrarBack: true,
      onLogout: () async {
        await SharedPreferencesHelper.clearToken(); // Elimina el token
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      contenido: contenidoPantalla,
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
