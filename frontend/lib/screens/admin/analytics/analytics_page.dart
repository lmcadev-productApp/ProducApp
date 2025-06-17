import 'package:flutter/material.dart';
import 'package:frontend/widgets/section/section_header.dart';

class AdminAnalytics extends StatefulWidget {
  @override
  _AdminAnalyticsState createState() => _AdminAnalyticsState();
}

class _AdminAnalyticsState extends State<AdminAnalytics> {
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
      titulo: 'Analiticas',
      contenidoPersonalizado: contenidoPantalla,
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
