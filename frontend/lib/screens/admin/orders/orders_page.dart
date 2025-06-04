import 'package:flutter/material.dart';
import 'package:frontend/widgets/section/section_header.dart';

class AdminOrders extends StatefulWidget {
  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
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
      titulo: 'Ordenes',
      contenido: contenidoPantalla,
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
