import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final String titulo;
  final Widget contenido;
  final Color? colorHeader;
  final List<Widget>? acciones;

  const BaseScreen({
    Key? key,
    required this.titulo,
    required this.contenido,
    this.colorHeader,
    this.acciones,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: colorHeader ?? const Color(0xFF4A90E2),
        elevation: 0,
        actions: acciones,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: contenido,
      ),
    );
  }
}
