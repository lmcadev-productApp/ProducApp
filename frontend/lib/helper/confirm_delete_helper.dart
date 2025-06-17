import 'package:flutter/material.dart';
import 'package:frontend/helper/snackbar_helper.dart';
import 'package:frontend/utils/AppColors.dart' show AppColors;
import 'package:flutter/material.dart';

Future<void> confirmarEliminacion<T>({
  required BuildContext context,
  required Future<void> Function() onDelete,
  String mensajeConfirmacion = '¿Deseas eliminar este elemento?',
  String mensajeExito = 'Elemento eliminado',
  String mensajeError = 'Error al eliminar',
}) async {
  final confirm = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Encabezado rojo con título y botón cerrar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Eliminar Etapa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(ctx).pop(false),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Contenido del diálogo
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                mensajeConfirmacion,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            // Botones
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Botón Cancelar
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.grey.shade600; // al presionar
                          }
                          return Colors.grey.shade300; // por defecto
                        },
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 8),

                  // Botón Eliminar
                  ElevatedButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.red.shade700; // al presionar
                          }
                          return Colors.white; // por defecto
                        },
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red.shade700),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.red.shade700),
                      ),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: const Text('Eliminar'),
                  ),
                ],
              ),

            ),
          ],
        ),
      );
    },
  );

  if (confirm == true) {
    try {
      await onDelete();
      showCustomSnackBar(context, mensajeExito);
    } catch (e) {
      print('Error al eliminar: $e');
      showCustomSnackBar(context, mensajeError);
    }
  }
}
