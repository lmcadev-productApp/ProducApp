import 'package:flutter/material.dart';

/// Widget de botón personalizado y reutilizable
/// Proporciona un diseño consistente con bordes redondeados,
/// colores personalizables y espaciado opcional
class CustomButton extends StatelessWidget {
  // Propiedades básicas
  final String texto; // Texto que muestra el botón
  final Color backgroundColor; // Color de fondo del botón
  final Color foregroundColor; // Color del texto y elementos internos
  final bool bottomSpacing; // Si agrega espacio debajo del botón
  final VoidCallback? onPressed; // Función que se ejecuta al presionar

  // Propiedades adicionales para mayor flexibilidad
  final double? width; // Ancho personalizable (opcional)
  final double height; // Alto del botón
  final double borderRadius; // Radio de los bordes redondeados
  final double elevation; // Elevación/sombra del botón
  final IconData? icon; // Icono opcional al lado del texto
  final bool isLoading; // Estado de carga (muestra spinner)
  final double fontSize; // Tamaño de fuente del texto
  final FontWeight fontWeight; // Peso de la fuente

  /// Constructor del CustomButton
  /// [texto] y [onPressed] son requeridos para funcionalidad básica
  const CustomButton({
    super.key,
    required this.texto, // Obligatorio: texto del botón
    required this.onPressed, // Obligatorio: acción del botón
    this.backgroundColor = const Color(0xFF4A90E2), // Azul por defecto
    this.foregroundColor = Colors.white, // Texto blanco por defecto
    this.bottomSpacing = false, // Sin espacio inferior por defecto
    this.width, // Opcional: ancho personalizado
    this.height = 50.0, // Alto por defecto 50px
    this.borderRadius = 25.0, // Bordes muy redondeados por defecto
    this.elevation = 2.0, // Sombra sutil por defecto
    this.icon, // Opcional: icono
    this.isLoading = false, // Por defecto no está cargando
    this.fontSize = 16.0, // Tamaño de fuente por defecto
    this.fontWeight = FontWeight.w600, // Fuente semi-bold por defecto
  });

  @override
  Widget build(BuildContext context) {
    // Construye el botón principal
    final button = _buildMainButton();

    // Retorna con o sin espacio inferior según se configure
    return bottomSpacing
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              button,
              const SizedBox(height: 16), // Espacio de 16px debajo
            ],
          )
        : button; // Solo el botón sin espacio extra
  }

  /// Construye el botón principal con todas las personalizaciones
  Widget _buildMainButton() {
    return SizedBox(
      width: width ?? double.infinity, // Usa ancho personalizado o completo
      height: height, // Alto configurado
      child: ElevatedButton(
        onPressed:
            isLoading ? null : onPressed, // Deshabilitado si está cargando
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: backgroundColor
              .withOpacity(0.6), // Color cuando está deshabilitado
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation,
          // Animación de presionado
          shadowColor: backgroundColor.withOpacity(0.3),
        ),
        child:
            _buildButtonContent(), // Contenido del botón (texto, icono, loading)
      ),
    );
  }

  /// Construye el contenido interno del botón
  /// Maneja texto, icono y estado de carga
  Widget _buildButtonContent() {
    // Si está cargando, muestra spinner
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
        ),
      );
    }

    // Si tiene icono, crea fila con icono + texto
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: fontSize + 2), // Icono ligeramente más grande que el texto
          const SizedBox(width: 8), // Espacio entre icono y texto
          Text(
            texto,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ],
      );
    }

    // Solo texto sin icono
    return Text(
      texto,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

// === VARIANTES PREDEFINIDAS PARA CASOS COMUNES ===

/// Botón primario (azul) para acciones principales
class PrimaryButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final bool bottomSpacing;
  final bool isLoading;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.bottomSpacing = false,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      texto: texto,
      onPressed: onPressed,
      backgroundColor: const Color(0xFF4A90E2), // Azul
      bottomSpacing: bottomSpacing,
      isLoading: isLoading,
      icon: icon,
    );
  }
}

/// Botón secundario (gris) para acciones secundarias
class SecondaryButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final bool bottomSpacing;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.bottomSpacing = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      texto: texto,
      onPressed: onPressed,
      backgroundColor: Colors.grey[600]!, // Gris
      foregroundColor: Colors.white,
      bottomSpacing: bottomSpacing,
      icon: icon,
    );
  }
}

/// Botón de éxito (verde) para confirmaciones
class SuccessButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final bool bottomSpacing;
  final IconData? icon;

  const SuccessButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.bottomSpacing = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      texto: texto,
      onPressed: onPressed,
      backgroundColor: const Color(0xFF2ECC71), // Verde
      bottomSpacing: bottomSpacing,
      icon: icon ?? Icons.check, // Icono de check por defecto
    );
  }
}

/// Botón de peligro (rojo) para acciones destructivas
class DangerButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final bool bottomSpacing;
  final IconData? icon;

  const DangerButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.bottomSpacing = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      texto: texto,
      onPressed: onPressed,
      backgroundColor: const Color(0xFFE74C3C), // Rojo
      bottomSpacing: bottomSpacing,
      icon: icon ?? Icons.delete, // Icono de eliminar por defecto
    );
  }
}

/// Botón outline (solo borde) para acciones sutiles
class OutlineButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final Color color;
  final bool bottomSpacing;
  final IconData? icon;

  const OutlineButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.color = const Color(0xFF4A90E2),
    this.bottomSpacing = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 8),
                  Text(texto,
                      style:
                          TextStyle(color: color, fontWeight: FontWeight.w600)),
                ],
              )
            : Text(texto,
                style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

/*
EJEMPLOS DE USO SIMPLES:

// 1. BOTÓN BÁSICO (como el original)
CustomButton(
  texto: 'Continuar',
  onPressed: () => print('Botón presionado'),
)

// 2. BOTÓN CON ESPACIADO INFERIOR
CustomButton(
  texto: 'Guardar',
  onPressed: guardarDatos,
  bottomSpacing: true,  // Agrega espacio debajo
)

// 3. BOTÓN PERSONALIZADO
CustomButton(
  texto: 'Mi Botón',
  onPressed: miAccion,
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
  borderRadius: 15,
  icon: Icons.star,
)

// 4. BOTÓN CON ESTADO DE CARGA
CustomButton(
  texto: 'Procesando...',
  onPressed: procesar,
  isLoading: true,  // Muestra spinner
)

// 5. BOTÓN CON ANCHO PERSONALIZADO
CustomButton(
  texto: 'Botón Pequeño',
  onPressed: accion,
  width: 200,  // Ancho específico
)

// 6. USANDO VARIANTES PREDEFINIDAS (MÁS FÁCIL)

// Botón primario
PrimaryButton(
  texto: 'Confirmar',
  onPressed: confirmar,
)

// Botón de éxito
SuccessButton(
  texto: 'Guardar',
  onPressed: guardar,
)

// Botón de peligro
DangerButton(
  texto: 'Eliminar',
  onPressed: eliminar,
)

// Botón outline
OutlineButton(
  texto: 'Cancelar',
  onPressed: cancelar,
)

// 7. EJEMPLO PRÁCTICO - FORMULARIO
Column(
  children: [
    // Campos del formulario aquí...
    
    PrimaryButton(
      texto: 'Guardar Datos',
      onPressed: _isLoading ? null : guardarFormulario,
      isLoading: _isLoading,
      bottomSpacing: true,
      icon: Icons.save,
    ),
    
    SecondaryButton(
      texto: 'Cancelar',
      onPressed: () => Navigator.pop(context),
      icon: Icons.cancel,
    ),
  ],
)

// 8. BOTONES CON DIFERENTES ESTADOS
class MiFormulario extends StatefulWidget {
  @override
  _MiFormularioState createState() => _MiFormularioState();
}

class _MiFormularioState extends State<MiFormulario> {
  bool _isLoading = false;

  Future<void> _guardar() async {
    setState(() => _isLoading = true);
    
    // Simular guardado
    await Future.delayed(Duration(seconds: 2));
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          texto: _isLoading ? 'Guardando...' : 'Guardar',
          onPressed: _isLoading ? null : _guardar,
          isLoading: _isLoading,
          bottomSpacing: true,
        ),
        
        OutlineButton(
          texto: 'Cancelar',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
*/
