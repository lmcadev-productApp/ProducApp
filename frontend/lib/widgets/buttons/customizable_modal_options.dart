import 'package:flutter/material.dart';

// Clase para definir las acciones del modal
class AccionModal {
  final IconData icono;
  final String titulo;
  final VoidCallback alPresionar;
  final Color? colorIcono;
  final Color? colorTexto;

  AccionModal({
    required this.icono,
    required this.titulo,
    required this.alPresionar,
    this.colorIcono,
    this.colorTexto,
  });
}

// Widget personalizable para mostrar opciones
//Es un menú emergente que aparece desde abajo cuando se toca un elemento (usuario, producto, archivo, etc.).
class ModalOptionsCustomizable {
  static void mostrar({
    required BuildContext context,
    required String titulo,
    required List<AccionModal> acciones,
    Color colorFondo = const Color(0xFF4A90E2),
    Color colorTitulo = Colors.white,
    Color colorDivisor = Colors.white70,
    double radioEsquinas = 20.0,
    TextStyle? estiloTitulo,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radioEsquinas),
        ),
      ),
      backgroundColor: colorFondo,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Título personalizable
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                titulo,
                style: estiloTitulo ??
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: colorTitulo,
                    ),
              ),
            ),
            Divider(color: colorDivisor),

            // Acciones dinámicas
            ...acciones
                .map((accion) => ListTile(
                      leading: Icon(
                        accion.icono,
                        color: accion.colorIcono ?? colorTitulo,
                      ),
                      title: Text(
                        accion.titulo,
                        style: TextStyle(
                          color: accion.colorTexto ?? colorTitulo,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        accion.alPresionar();
                      },
                    ))
                .toList(),
          ],
        );
      },
    );
  }
}

// Ejemplos de uso:
/*
// 1. Para usuarios 
void mostrarOpcionesUsuario(BuildContext context, dynamic usuario) {
  ModalOptionsCustomizable.mostrar(
    context: context,
    titulo: 'Usuario seleccionado: ${usuario.nombre}',
    acciones: [
      AccionModal(
        icono: Icons.edit,
        titulo: 'Editar',
        alPresionar: () {
          mostrarEditarUsuario(context);
          print('Editar usuario: ${usuario.nombre}');
        },
      ),
      AccionModal(
        icono: Icons.delete,
        titulo: 'Eliminar',
        alPresionar: () {
          print('Eliminar usuario: ${usuario.nombre}');
        },
      ),
    ],
  );
}

// 2. Para productos
void mostrarOpcionesProducto(BuildContext context, dynamic producto) {
  ModalOptionsCustomizable.mostrar(
    context: context,
    titulo: 'Producto: ${producto.nombre}',
    colorFondo: const Color(0xFF2E7D32), // Verde
    acciones: [
      AccionModal(
        icono: Icons.visibility,
        titulo: 'Ver detalles',
        alPresionar: () => print('Ver producto: ${producto.nombre}'),
      ),
      AccionModal(
        icono: Icons.edit,
        titulo: 'Editar',
        alPresionar: () => print('Editar producto: ${producto.nombre}'),
      ),
      AccionModal(
        icono: Icons.shopping_cart,
        titulo: 'Agregar al carrito',
        alPresionar: () => print('Agregar al carrito: ${producto.nombre}'),
      ),
      AccionModal(
        icono: Icons.delete,
        titulo: 'Eliminar',
        colorIcono: Colors.red[300],
        alPresionar: () => print('Eliminar producto: ${producto.nombre}'),
      ),
    ],
  );
}

// 3. Para archivos/documentos
void mostrarOpcionesArchivo(BuildContext context, dynamic archivo) {
  ModalOptionsCustomizable.mostrar(
    context: context,
    titulo: 'Archivo: ${archivo.nombre}',
    colorFondo: const Color(0xFF6A1B9A), // Morado
    radioEsquinas: 25.0,
    acciones: [
      AccionModal(
        icono: Icons.open_in_new,
        titulo: 'Abrir',
        alPresionar: () => print('Abrir archivo: ${archivo.nombre}'),
      ),
      AccionModal(
        icono: Icons.download,
        titulo: 'Descargar',
        alPresionar: () => print('Descargar archivo: ${archivo.nombre}'),
      ),
      AccionModal(
        icono: Icons.share,
        titulo: 'Compartir',
        alPresionar: () => print('Compartir archivo: ${archivo.nombre}'),
      ),
      AccionModal(
        icono: Icons.drive_file_rename_outline,
        titulo: 'Renombrar',
        alPresionar: () => print('Renombrar archivo: ${archivo.nombre}'),
      ),
      AccionModal(
        icono: Icons.delete,
        titulo: 'Eliminar',
        colorIcono: Colors.red[300],
        alPresionar: () => print('Eliminar archivo: ${archivo.nombre}'),
      ),
    ],
  );
}

// 4. Para notificaciones
void mostrarOpcionesNotificacion(BuildContext context, dynamic notificacion) {
  ModalOptionsCustomizable.mostrar(
    context: context,
    titulo: 'Notificación',
    colorFondo: const Color(0xFFFF6F00), // Naranja
    acciones: [
      AccionModal(
        icono: Icons.mark_email_read,
        titulo: 'Marcar como leída',
        alPresionar: () => print('Marcar como leída'),
      ),
      AccionModal(
        icono: Icons.reply,
        titulo: 'Responder',
        alPresionar: () => print('Responder notificación'),
      ),
      AccionModal(
        icono: Icons.delete,
        titulo: 'Eliminar',
        alPresionar: () => print('Eliminar notificación'),
      ),
    ],
  );
}

// 5. Ejemplo con estilos completamente personalizados
void mostrarOpcionesPersonalizadas(BuildContext context, String elemento) {
  ModalOptionsCustomizable.mostrar(
    context: context,
    titulo: 'Opciones avanzadas',
    colorFondo: Colors.black87,
    colorTitulo: Colors.amber,
    colorDivisor: Colors.amber.withOpacity(0.3),
    radioEsquinas: 30.0,
    estiloTitulo: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 16,
      color: Colors.amber,
      letterSpacing: 2.0,
    ),
    acciones: [
      AccionModal(
        icono: Icons.settings,
        titulo: 'Configuración',
        colorIcono: Colors.amber,
        colorTexto: Colors.white,
        alPresionar: () => print('Configuración'),
      ),
      AccionModal(
        icono: Icons.info,
        titulo: 'Información',
        colorIcono: Colors.blue[300],
        colorTexto: Colors.white,
        alPresionar: () => print('Información'),
      ),
    ],
  );
}

*/
