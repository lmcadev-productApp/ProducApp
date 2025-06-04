import 'package:flutter/material.dart';
import 'package:frontend/widgets/section/section_header.dart';

class AdminStages extends StatefulWidget {
  @override
  _AdminStagesState createState() => _AdminStagesState();
}

class _AdminStagesState extends State<AdminStages> {
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
      titulo: 'Etapas de Producción',
      contenido: contenidoPantalla,
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
