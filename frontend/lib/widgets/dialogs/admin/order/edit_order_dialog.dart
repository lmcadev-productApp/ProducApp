import 'package:flutter/material.dart';
import 'package:frontend/helper/input_form_field.dart' show inputFormField;
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/services/orders/order_service.dart';
import 'package:frontend/utils/AppColors.dart' show AppColors;
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarEditarOrden(
    BuildContext context,
    WorkOrders ordenOriginal,
    VoidCallback onActualizada,
    ) {
  final descripcionCtrl = TextEditingController(text: ordenOriginal.descripcion);
  final fechaInicioCtrl = TextEditingController(
    text: ordenOriginal.fechaInicio?.toIso8601String().split('T').first ?? '',
  );
  final fechaFinCtrl = TextEditingController(
    text: ordenOriginal.fechaFin?.toIso8601String().split('T').first ?? '',
  );

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          bool isLoading = false;
          bool botonActivo = descripcionCtrl.text.isNotEmpty &&
              fechaInicioCtrl.text.isNotEmpty &&
              fechaFinCtrl.text.isNotEmpty;

          void validarBoton() {
            setState(() {
              botonActivo = descripcionCtrl.text.isNotEmpty &&
                  fechaInicioCtrl.text.isNotEmpty &&
                  fechaFinCtrl.text.isNotEmpty;
            });
          }

          descripcionCtrl.addListener(validarBoton);
          fechaInicioCtrl.addListener(validarBoton);
          fechaFinCtrl.addListener(validarBoton);

          return DialogoGeneral(
            titulo: 'Editar orden',
            contenido: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputFormField(
                  label: 'Descripción',
                  hint: 'Ingrese la descripción',
                  controller: descripcionCtrl,
                ),
                const SizedBox(height: 16),
                inputFormField(
                  label: 'Fecha de inicio',
                  hint: 'YYYY-MM-DD',
                  controller: fechaInicioCtrl,
                  tipoTeclado: TextInputType.datetime,
                  isPassword: false,
                  maxLines: 1,
                  passwordVisible: true,
                  onTogglePassword: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: ordenOriginal.fechaInicio ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      fechaInicioCtrl.text = picked.toIso8601String().split('T').first;
                    }
                  },
                ),
                const SizedBox(height: 16),
                inputFormField(
                  label: 'Fecha fin',
                  hint: 'YYYY-MM-DD',
                  controller: fechaFinCtrl,
                  tipoTeclado: TextInputType.datetime,
                  isPassword: false,
                  maxLines: 1,
                  passwordVisible: true,
                  onTogglePassword: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: ordenOriginal.fechaFin ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      fechaFinCtrl.text = picked.toIso8601String().split('T').first;
                    }
                  },
                ),
              ],
            ),
            botonOkPersonalizado: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
              child: Wrap(
                spacing: 14,
                children: [
                  PrimaryButton(
                    text: 'Cancelar',
                    width: 135,
                    height: 48,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    backgroundColor: AppColors.azulIntermedio,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  PrimaryButton(
                    text: 'Actualizar',
                    isEnabled: botonActivo,
                    width: 135,
                    height: 48,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    backgroundColor: botonActivo
                        ? AppColors.azulIntermedio
                        : AppColors.grisTextoSecundario,
                    onPressed: () async {
                      try {
                        final descripcion = descripcionCtrl.text.trim();
                        if (descripcion.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('La descripción no puede estar vacía'),
                            ),
                          );
                          return;
                        }

                        final inicio = DateTime.parse(fechaInicioCtrl.text);
                        final fin = DateTime.parse(fechaFinCtrl.text);

                        if (fin.isBefore(inicio)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('La fecha fin no puede ser anterior a la de inicio'),
                            ),
                          );
                          return;
                        }

                        setState(() => isLoading = true);

                        final ordenEditada = WorkOrders(
                          id: ordenOriginal.id,
                          descripcion: descripcion,
                          fechaInicio: inicio,
                          fechaFin: fin,
                          estado: ordenOriginal.estado,
                          usuario: ordenOriginal.usuario,
                          etapas: ordenOriginal.etapas,
                        );

                        await OrderService().updateOrden(ordenOriginal.id!, ordenEditada);

                        Navigator.of(context).pop();
                        onActualizada();
                      } catch (e) {
                        print('Error al actualizar orden: $e');
                      } finally {
                        setState(() => isLoading = false);
                      }
                    },
                  ),
                ],
              ),
            ),

          );
        },
      );
    },
  ).then((_) {
    descripcionCtrl.dispose();
    fechaInicioCtrl.dispose();
    fechaFinCtrl.dispose();
  });
}
