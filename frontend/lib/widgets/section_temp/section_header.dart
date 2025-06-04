import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final String titulo;
  final Widget contenido;
  final Color? colorHeader;
  final bool mostrarBack;
  final bool mostrarLogout;
  final VoidCallback? onBack;
  final VoidCallback? onLogout;

  const BaseScreen({
    Key? key,
    required this.titulo,
    required this.contenido,
    this.colorHeader,
    this.mostrarBack = false,
    this.mostrarLogout = false,
    this.onBack,
    this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: mostrarBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBack ?? () => Navigator.pop(context),
              )
            : null,
        title: Text(
          titulo,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: colorHeader ?? const Color(0xFF4A90E2),
        elevation: 0,
        actions: mostrarLogout
            ? [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: onLogout,
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: contenido,
      ),
    );
  }
}
/*

// Solo flecha de regreso
BaseScreen(
  titulo: 'Detalles',
  mostrarBack: true,
  contenido: MiContenido(),
),

// Solo botón de cerrar sesión
BaseScreen(
  titulo: 'Inicio',
  mostrarLogout: true,
  onLogout: () {
    // Lógica de cerrar sesión
  },
  contenido: MiContenido(),
),


// Ambos
BaseScreen(
  titulo: 'Perfil',
  mostrarBack: true,
  mostrarLogout: true,
  onLogout: () => cerrarSesion(),
  contenido: MiContenido(),

*/
