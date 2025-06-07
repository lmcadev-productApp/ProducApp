import 'package:flutter/material.dart';

/// Widget de carga reutilizable con diseño atractivo
/// Muestra un indicador de progreso con mensaje opcional
/// y fondo semi-transparente
class LoadingDialog extends StatelessWidget {
  // Propiedades de personalización
  final String? mensaje; // Mensaje opcional debajo del loader
  final Color color; // Color del indicador
  final Color? colorFondo; // Color del fondo (opcional)
  final double size; // Tamaño del indicador
  final double strokeWidth; // Grosor de la línea del indicador
  final bool mostrarFondo; // Si mostrar fondo semi-transparente
  final bool esModal; // Si es modal (bloquea interacción)

  /// Constructor del LoadingDialog
  /// Todos los parámetros son opcionales con valores por defecto
  const LoadingDialog({
    super.key,
    this.mensaje, // Opcional: texto de carga
    this.color = const Color(0xFF4A90E2), // Azul por defecto
    this.colorFondo, // Opcional: color de fondo personalizado
    this.size = 50.0, // Tamaño por defecto 50px
    this.strokeWidth = 4.0, // Grosor por defecto 4px
    this.mostrarFondo = true, // Por defecto muestra fondo
    this.esModal = false, // Por defecto no es modal
  });

  @override
  Widget build(BuildContext context) {
    // Contenido principal del loading
    final contenidoLoading = _construirContenidoLoading();

    // Si es modal, envuelve en un diálogo
    if (esModal) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: contenidoLoading,
      );
    }

    // Si no es modal, solo muestra el contenido
    return contenidoLoading;
  }

  /// Construye el contenido principal del loading
  Widget _construirContenidoLoading() {
    return Container(
      // Fondo semi-transparente si está habilitado
      color: mostrarFondo
          ? (colorFondo ?? Colors.black.withOpacity(0.3))
          : Colors.transparent,
      child: Center(
        child: Container(
          // Contenedor redondeado para el indicador
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            // Sombra sutil para darle profundidad
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Tamaño mínimo necesario
            children: [
              // === INDICADOR DE PROGRESO ===
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  strokeWidth: strokeWidth,
                  color: color,
                  backgroundColor: color.withOpacity(0.2), // Fondo tenue
                ),
              ),

              // === MENSAJE OPCIONAL ===
              if (mensaje != null) ...[
                const SizedBox(height: 16), // Espacio entre indicador y texto
                Text(
                  mensaje!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// === CLASE HELPER PARA MOSTRAR LOADING FÁCILMENTE ===

/// Clase utilitaria para mostrar y ocultar loading de forma sencilla
class LoadingHelper {
  static OverlayEntry? _overlayEntry;

  /// Muestra un loading overlay en toda la pantalla
  static void mostrar(
    BuildContext context, {
    String? mensaje,
    Color color = const Color(0xFF4A90E2),
  }) {
    ocultar(); // Asegura que no haya otro loading activo

    _overlayEntry = OverlayEntry(
      builder: (context) => LoadingDialog(
        mensaje: mensaje,
        color: color,
        mostrarFondo: true,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Oculta el loading overlay
  static void ocultar() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// Muestra loading modal (diálogo)
  static void mostrarModal(
    BuildContext context, {
    String? mensaje,
    Color color = const Color(0xFF4A90E2),
  }) {
    showDialog(
      context: context,
      barrierDismissible: false, // No se puede cerrar tocando fuera
      builder: (context) => LoadingDialog(
        mensaje: mensaje,
        color: color,
        esModal: true,
        mostrarFondo: false, // El diálogo ya tiene su propio fondo
      ),
    );
  }

  /// Oculta loading modal
  static void ocultarModal(BuildContext context) {
    Navigator.of(context).pop();
  }
}

// === VARIANTES PREDEFINIDAS PARA DIFERENTES SITUACIONES ===

/// Loading específico para guardado
class LoadingGuardar extends StatelessWidget {
  const LoadingGuardar({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingDialog(
      mensaje: 'Guardando...',
      color: Color(0xFF2ECC71), // Verde para guardar
      size: 60,
    );
  }
}

/// Loading específico para carga de datos
class LoadingCargar extends StatelessWidget {
  const LoadingCargar({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingDialog(
      mensaje: 'Cargando datos...',
      color: Color(0xFF4A90E2), // Azul para cargar
      size: 55,
    );
  }
}

/// Loading específico para eliminar
class LoadingEliminar extends StatelessWidget {
  const LoadingEliminar({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoadingDialog(
      mensaje: 'Eliminando...',
      color: Color(0xFFE74C3C), // Rojo para eliminar
      size: 50,
    );
  }
}

/*
EJEMPLOS DE USO SÚPER SIMPLES:

// 1. LOADING BÁSICO (como el original pero más bonito)
LoadingDialog()

// 2. LOADING CON MENSAJE
LoadingDialog(
  mensaje: 'Cargando...',
)

// 3. LOADING PERSONALIZADO
LoadingDialog(
  mensaje: 'Procesando datos...',
  color: Colors.green,
  size: 60,
)

// 4. USANDO EL HELPER (MÁS FÁCIL) - Para overlay
// Mostrar
LoadingHelper.mostrar(context, mensaje: 'Cargando...');
// Ocultar después de 3 segundos
Future.delayed(Duration(seconds: 3), () {
  LoadingHelper.ocultar();
});

// 5. LOADING MODAL (diálogo)
// Mostrar
LoadingHelper.mostrarModal(context, mensaje: 'Guardando...');
// Ocultar
LoadingHelper.ocultarModal(context);

// 6. USANDO VARIANTES PREDEFINIDAS
LoadingGuardar()    // Verde con mensaje "Guardando..."
LoadingCargar()     // Azul con mensaje "Cargando datos..."
LoadingEliminar()   // Rojo con mensaje "Eliminando..."

// 7. EJEMPLO PRÁCTICO EN FUNCIÓN ASYNC
Future<void> guardarDatos() async {
  // Mostrar loading
  LoadingHelper.mostrar(context, mensaje: 'Guardando...');
  
  try {
    // Simular operación
    await Future.delayed(Duration(seconds: 2));
    // Aquí iría tu lógica de guardado
    
  } finally {
    // Siempre ocultar loading
    LoadingHelper.ocultar();
  }
}

// 8. LOADING DURANTE NAVEGACIÓN
void irAOtraPantalla() async {
  LoadingHelper.mostrar(context, mensaje: 'Preparando...');
  
  // Simular preparación de datos
  await prepararDatos();
  
  LoadingHelper.ocultar();
  Navigator.push(context, MaterialPageRoute(
    builder: (_) => OtraPantalla(),
  ));
}

// 9. LOADING SIN FONDO (para usar dentro de otro widget)
Container(
  height: 200,
  child: LoadingDialog(
    mensaje: 'Cargando...',
    mostrarFondo: false,  // Sin fondo
  ),
)

// 10. LOADING EN STACK (superpuesto)
Stack(
  children: [
    MiContenidoPrincipal(),
    if (estaCargando)
      LoadingDialog(mensaje: 'Actualizando...'),
  ],
)
*/
