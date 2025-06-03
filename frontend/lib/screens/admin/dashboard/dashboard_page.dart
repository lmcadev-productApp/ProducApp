import 'package:flutter/material.dart';
import 'package:frontend/widgets/section/section_header.dart';

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
      contenido: contenidoPantalla,
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
