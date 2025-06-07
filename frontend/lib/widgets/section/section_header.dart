import 'package:flutter/material.dart';

/// Widget base reutilizable para crear pantallas con estructura consistente este el widget principal para todas las ptanllas
/// Proporciona un AppBar personalizable y un área de contenido con padding
class BaseScreen extends StatelessWidget {
  // Propiedades del widget
  final String titulo; // Título que se muestra en el AppBar
  final Widget contenido; // Widget principal que se renderiza en el body
  final Color? colorHeader; // Color personalizable del AppBar (opcional)
  final bool mostrarBack; // Controla si se muestra el botón de regreso
  final bool mostrarLogout; // Controla si se muestra el botón de cerrar sesión
  final VoidCallback? onBack; // Callback personalizado para el botón de regreso
  final VoidCallback? onLogout; // Callback para el botón de cerrar sesión

  /// Constructor del widget BaseScreen
  /// [titulo] y
  /// [contenido] son requeridos
  /// Las demás propiedades tienen valores por defecto
  const BaseScreen({
    Key? key,
    required this.titulo, // Obligatorio: título del AppBar
    required this.contenido, // Obligatorio: contenido principal
    this.colorHeader, // Opcional: color del header
    this.mostrarBack = false, // Por defecto no muestra botón de regreso
    this.mostrarLogout = false, // Por defecto no muestra botón de logout
    this.onBack, // Opcional: acción personalizada de regreso
    this.onLogout, // Opcional: acción de cerrar sesión
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerColor = colorHeader ?? const Color(0xFF4A90E2);

    return Scaffold(
      // Configuración del AppBar
      appBar: AppBar(
        // Botón de regreso condicional
        leading: mostrarBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                // Si se proporciona onBack personalizado lo usa, sino usa Navigator.pop
                onPressed: onBack ?? () => Navigator.pop(context),
              )
            : null, // No muestra botón si mostrarBack es false

        // Configuración del título
        title: Text(
          titulo,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
<<<<<<< HEAD
        backgroundColor: headerColor,
        elevation: 0,
        // Fuerza el tema de iconos a blanco
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
=======

        // Color del AppBar: usa colorHeader personalizado o azul por defecto
        backgroundColor: colorHeader ?? const Color(0xFF4A90E2),
        elevation: 0, // Sin sombra en el AppBar

        // Botón de logout condicional en el lado derecho
>>>>>>> feature-admin-ui-user-management
        actions: mostrarLogout
            ? [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed:
                      onLogout, // Ejecuta la función de logout proporcionada
                ),
              ]
            : null, // No muestra acciones si mostrarLogout es false
      ),

      // Cuerpo de la pantalla con padding consistente
      body: Padding(
        padding: const EdgeInsets.all(16), // Padding de 16px en todos los lados
        child: contenido, // Renderiza el widget contenido proporcionado
      ),
    );
  }
}
<<<<<<< HEAD
=======

/*
EJEMPLOS DE USO:

// 1. Pantalla básica con solo título
BaseScreen(
  titulo: 'Mi Pantalla',
  contenido: Text('Contenido aquí'),
),

// 2. Solo con flecha de regreso
BaseScreen(
  titulo: 'Detalles',
  mostrarBack: true,
  contenido: MiContenido(),
),

// 3. Solo con botón de cerrar sesión
BaseScreen(
  titulo: 'Inicio',
  mostrarLogout: true,
  onLogout: () {
    // Lógica personalizada de cerrar sesión
    print('Cerrando sesión...');
  },
  contenido: MiContenido(),
),

// 4. Con ambos botones
BaseScreen(
  titulo: 'Perfil',
  mostrarBack: true,
  mostrarLogout: true,
  onLogout: () => cerrarSesion(),
  contenido: MiContenido(),
),

// 5. Con color personalizado del header
BaseScreen(
  titulo: 'Configuración',
  colorHeader: Colors.green,
  mostrarBack: true,
  contenido: MiContenido(),
),

// 6. Con callback personalizado de regreso
BaseScreen(
  titulo: 'Formulario',
  mostrarBack: true,
  onBack: () {
    // Lógica personalizada antes de regresar
    // Por ejemplo, mostrar diálogo de confirmación
    showDialog(context: context, builder: (_) => AlertDialog(...));
  },
  contenido: MiFormulario(),
),
*/
>>>>>>> feature-admin-ui-user-management
