import 'package:flutter/material.dart';
import 'package:frontend/utils/AppColors.dart';

/// Widget de diálogo reutilizable para ventanas emergentes
/// Proporciona una estructura consistente con header coloreable,
/// contenido personalizable y botones de acción
class DialogoGeneral extends StatelessWidget {
  // Propiedades principales
  final String titulo; // Título que aparece en el header
  final Widget contenido; // Contenido principal del diálogo
  final String textoBotonOk; // Texto del botón de confirmación
  final String textoBotonCancelar; // Texto del botón de cancelar
  final VoidCallback? onOk; // Acción del botón OK
  final VoidCallback? onCancelar; // Acción del botón Cancelar
  final Color color; // Color del theme del diálogo
  final Widget? botonOkPersonalizado;

  // Propiedades adicionales para mayor flexibilidad
  final bool mostrarBotonCancelar; // Controla si mostrar botón cancelar
  final bool mostrarBotonCerrar; // Controla si mostrar X en header
  final double? ancho; // Ancho personalizable del diálogo
  final double? alto; // Alto personalizable del diálogo

  /// Constructor del DialogoGeneral
  /// [titulo] y [contenido] son obligatorios
  /// Los demás parámetros tienen valores por defecto
  const DialogoGeneral({
    Key? key, // Key para el widget
    required this.titulo, // Obligatorio: título del diálogo
    required this.contenido, // Obligatorio: contenido a mostrar
    this.textoBotonOk = 'Aceptar', // Texto por defecto del botón OK
    this.textoBotonCancelar =
    'Cancelar', // Texto por defecto del botón cancelar
    this.onOk, // Opcional: función del botón OK
    this.onCancelar, // Opcional: función del botón cancelar
    this.color = AppColors.azulIntermedio, // Color azul por defecto
    this.mostrarBotonCancelar = true, // Por defecto muestra botón cancelar
    this.mostrarBotonCerrar = true, // Por defecto muestra X en header
    this.ancho, // Opcional: ancho personalizado
    this.alto, this.botonOkPersonalizado, // Opcional: alto personalizado
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxAlto = alto ?? MediaQuery
        .of(context)
        .size
        .height * 0.8;

    return Dialog(
      backgroundColor: AppColors.azulClaroFondo,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxAlto,
          minWidth: ancho ?? 300,
        ),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _construirHeader(context),
              Flexible(child: _construirCuerpo(context)),
            ],
          ),
        ),
      ),
    );
  }

  /// Construye el header del diálogo con título y botón cerrar
  Widget _construirHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: color, // Color personalizable
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12), // Solo esquinas superiores redondeadas
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Título del diálogo
          Expanded(
            // Permite que el título use el espacio disponible
            child: Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis, // Trunca si es muy largo
            ),
          ),

          // Botón cerrar (X) - solo si está habilitado
          if (mostrarBotonCerrar)
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.white),
              iconSize: 20,
              tooltip: 'Cerrar', // Ayuda de accesibilidad
            ),
        ],
      ),
    );
  }

  /// Construye el cuerpo del diálogo con contenido y botones
  Widget _construirCuerpo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: contenido,
            ),
          ),
          const SizedBox(height: 20),
          _construirBotones(context),
        ],
      ),
    );
  }

  /// Construye la fila de botones de acción
  /// Construye la fila de botones de acción
  Widget _construirBotones(BuildContext context) {
    // Si se proporciona un widget personalizado, se usa SOLO ese
    if (botonOkPersonalizado != null) {
      return botonOkPersonalizado!;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Botón Cancelar - solo si está habilitado
        if (mostrarBotonCancelar) ...[
          ElevatedButton(
            onPressed: onCancelar ?? () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.azulClaroFondo,
              foregroundColor: AppColors.grisTextoSecundario,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(textoBotonCancelar),
          ),
          const SizedBox(width: 10),
        ],

        // Botón OK/Aceptar estándar
        ElevatedButton(
          onPressed: onOk,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: AppColors.grisTextoSecundario,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(textoBotonOk),
        ),
      ],
    );
  }
}


// === CLASE HELPER PARA MOSTRAR DIÁLOGOS FÁCILMENTE ===

/// Clase utilitaria para mostrar diferentes tipos de diálogos
class DialogoHelper {
  /// Muestra un diálogo de confirmación simple
  static Future<bool?> mostrarConfirmacion(
    BuildContext context, {
    required String titulo,
    required String mensaje,
    String textoOk = 'Aceptar',
    String textoCancelar = 'Cancelar',
    Color color = const Color(0xFF3498DB),
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => DialogoGeneral(
        titulo: titulo,
        contenido: Text(mensaje),
        textoBotonOk: textoOk,
        textoBotonCancelar: textoCancelar,
        color: color,
        onOk: () => Navigator.pop(context, true),
        onCancelar: () => Navigator.pop(context, false),
      ),
    );
  }

  /// Muestra un diálogo de información (solo botón OK)
  static Future<void> mostrarInformacion(
    BuildContext context, {
    required String titulo,
    required String mensaje,
    String textoOk = 'Entendido',
    Color color = const Color(0xFF2ECC71),
  }) {
    return showDialog(
      context: context,
      builder: (context) => DialogoGeneral(
        titulo: titulo,
        contenido: Text(mensaje),
        textoBotonOk: textoOk,
        mostrarBotonCancelar: false,
        color: color,
        onOk: () => Navigator.pop(context),
      ),
    );
  }

  /// Muestra un diálogo de error
  static Future<void> mostrarError(
    BuildContext context, {
    required String titulo,
    required String mensaje,
    String textoOk = 'Cerrar',
  }) {
    return mostrarInformacion(
      context,
      titulo: titulo,
      mensaje: mensaje,
      textoOk: textoOk,
      color: const Color(0xFFE74C3C), // Color rojo para errores
    );
  }
}

/*
EJEMPLOS DE USO SIMPLES:

// 1. DIÁLOGO BÁSICO DE CONFIRMACIÓN
DialogoGeneral(
  titulo: 'Confirmar acción',
  contenido: Text('¿Estás seguro de continuar?'),
  onOk: () {
    // Hacer algo
    Navigator.pop(context);
  },
),

// 2. DIÁLOGO PERSONALIZADO CON CONTENIDO COMPLEJO
DialogoGeneral(
  titulo: 'Configuración',
  color: Colors.green,
  contenido: Column(
    children: [
      Text('Elige una opción:'),
      SwitchListTile(
        title: Text('Notificaciones'),
        value: true,
        onChanged: (value) {},
      ),
    ],
  ),
  textoBotonOk: 'Guardar',
  onOk: () => guardarConfiguracion(),
),

// 3. DIÁLOGO SOLO CON BOTÓN OK
DialogoGeneral(
  titulo: 'Información',
  contenido: Text('Operación completada exitosamente'),
  mostrarBotonCancelar: false,
  textoBotonOk: 'Entendido',
  color: Colors.green,
  onOk: () => Navigator.pop(context),
),

// 4. USANDO LA CLASE HELPER (MÁS FÁCIL)

// Confirmación simple
final resultado = await DialogoHelper.mostrarConfirmacion(
  context,
  titulo: 'Eliminar elemento',
  mensaje: '¿Estás seguro de eliminar este elemento?',
);
if (resultado == true) {
  // Usuario confirmó
  eliminarElemento();
}

// Mostrar información
await DialogoHelper.mostrarInformacion(
  context,
  titulo: 'Éxito',
  mensaje: 'Los datos se guardaron correctamente',
);

// Mostrar error
await DialogoHelper.mostrarError(
  context,
  titulo: 'Error',
  mensaje: 'No se pudo conectar al servidor',
);

// 5. DIÁLOGO CON TAMAÑO PERSONALIZADO
DialogoGeneral(
  titulo: 'Vista previa',
  ancho: 400,
  alto: 300,
  contenido: Container(
    child: Image.network('https://ejemplo.com/imagen.jpg'),
  ),
),
*/
