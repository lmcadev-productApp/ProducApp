import 'package:flutter/material.dart';
import 'package:frontend/helper/snackbar_helper.dart';


Future<void> confirmarEliminacion({
  required BuildContext context,
  required Future<void> Function() onDelete,

  // ⚙️ Parámetros personalizables
  String titulo              = 'Eliminar elemento',
  String mensaje             = '¿Deseas eliminar este elemento?',
  String textoOk             = 'Eliminar',
  String textoCancelar       = 'Cancelar',
  Color  color               = Colors.red,

  String mensajeExito        = 'Elemento eliminado',
  String mensajeError        = 'Error al eliminar',
}) async {
  final bool? confirmado = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      titulo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(ctx).pop(false),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Mensaje
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(mensaje, style: const TextStyle(fontSize: 16)),
            ),

            // Botones
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                    ),
                    child: Text(textoCancelar),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      foregroundColor: color,
                      side: BorderSide(color: color),
                    ),
                    child: Text(textoOk),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );

  if (confirmado == true) {
    try {
      await onDelete();
      showCustomSnackBar(context, mensajeExito);
    } catch (e) {
      debugPrint('Error al eliminar: $e');
      showCustomSnackBar(context, mensajeError, backgroundColor: Colors.red);
    }
  }
}
