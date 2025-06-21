import 'package:flutter/material.dart';
import 'package:frontend/helper/input_form_field.dart';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/services/orders/order_service.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/utils/app_text_styles.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarAgregarOrderVisual(BuildContext context, VoidCallback onOrderCreado) {
  final descripcionCtrl = TextEditingController();
  final fechaInicioCtrl = TextEditingController();
  final fechaFinCtrl = TextEditingController();

  bool botonActivo = false;
  bool isLoading = false;

  late void Function(StateSetter) validarBoton;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          validarBoton = (StateSetter setStateInterno) {
            final activo = descripcionCtrl.text.isNotEmpty &&
                fechaInicioCtrl.text.isNotEmpty &&
                fechaFinCtrl.text.isNotEmpty;
            if (activo != botonActivo) {
              setStateInterno(() {
                botonActivo = activo;
              });
            }
          };

          descripcionCtrl.addListener(() => validarBoton(setState));
          fechaInicioCtrl.addListener(() => validarBoton(setState));
          fechaFinCtrl.addListener(() => validarBoton(setState));

          return DialogoGeneral(
            titulo: 'Agregar una nueva orden',
            contenido: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inputFormField(
                      label: 'Descripción',
                      hint: 'Ingrese la descripción de la orden',
                      controller: descripcionCtrl,
                    ),
                    const SizedBox(height: 20),

                    Text('Fecha de inicio', style: AppTextStyles.inputLabel),
                    const SizedBox(height: 8),
                    TextField(
                      controller: fechaInicioCtrl,
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          fechaInicioCtrl.text = picked.toIso8601String().split('T').first;
                          validarBoton(setState);
                        }
                      },
                      style: AppTextStyles.inputText,
                      decoration: InputDecoration(
                        hintText: 'YYYY-MM-DD',
                        hintStyle: AppTextStyles.inputHint,
                        suffixIcon: Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text('Fecha fin', style: AppTextStyles.inputLabel),
                    const SizedBox(height: 8),
                    TextField(
                      controller: fechaFinCtrl,
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          fechaFinCtrl.text = picked.toIso8601String().split('T').first;
                          validarBoton(setState);
                        }
                      },
                      style: AppTextStyles.inputText,
                      decoration: InputDecoration(
                        hintText: 'YYYY-MM-DD',
                        hintStyle: AppTextStyles.inputHint,
                        suffixIcon: Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text('Estado', style: AppTextStyles.inputLabel),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: 'PENDIENTE',
                      onChanged: null,
                      disabledHint: Text(
                        'PENDIENTE',
                        style: AppTextStyles.inputText.copyWith(fontWeight: FontWeight.bold),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'PENDIENTE',
                          child: Text('PENDIENTE'),
                        ),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.azulIntermedio),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    backgroundColor: AppColors.azulIntermedio,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  PrimaryButton(
                    text: 'Guardar',
                    isEnabled: botonActivo,
                    width: 135,
                    height: 48,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    backgroundColor:
                    botonActivo ? AppColors.azulIntermedio : AppColors.grisTextoSecundario,
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

                        final useridStr = await SharedPreferencesHelper.getUserId();
                        if (useridStr == null) {
                          throw Exception('No se pudo obtener el ID de usuario.');
                        }

                        final user = await UserService().getUserById(int.parse(useridStr));
                        final nuevaOrden = WorkOrders(
                          descripcion: descripcion,
                          fechaInicio: inicio,
                          fechaFin: fin,
                          estado: 'PENDIENTE',
                          usuario: user,
                          etapas: [],
                        );

                        final mensaje = await OrderService().createOrder(nuevaOrden);
                        print('Respuesta backend: $mensaje');

                        Navigator.of(context).pop();
                        onOrderCreado();
                      } catch (e) {
                        print('Error al crear orden: $e');
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
