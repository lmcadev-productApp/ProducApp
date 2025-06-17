import 'package:flutter/material.dart';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/services/orders/order_service.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';


void mostrarAgregarOrderVisual(
    BuildContext context, VoidCallback onOrderCreado) {
  final descripcionCtrl = TextEditingController();
  final fechaInicioCtrl = TextEditingController();
  final fechaFinCtrl = TextEditingController();

  bool botonActivo = false;

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

          // Agregamos los listeners SOLO una vez al construir
          descripcionCtrl.addListener(() => validarBoton(setState));
          fechaInicioCtrl.addListener(() => validarBoton(setState));
          fechaFinCtrl.addListener(() => validarBoton(setState));

          return DialogoGeneral(
            titulo: 'Agregar una nueva orden',
            contenido: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Descripción',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  TextField(
                    controller: descripcionCtrl,
                    decoration: InputDecoration(
                      hintText: 'Ingrese la descripción de la orden',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Fecha de inicio',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  TextField(
                    controller: fechaInicioCtrl,
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        fechaInicioCtrl.text =
                            picked.toIso8601String().split('T').first;
                        validarBoton(setState);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'YYYY-MM-DD',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Fecha fin',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  TextField(
                    controller: fechaFinCtrl,
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        fechaFinCtrl.text =
                            picked.toIso8601String().split('T').first;
                        validarBoton(setState);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'YYYY-MM-DD',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Estado',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Text(
                      'PENDIENTE',
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                  ),
                ],
              ),
            ),
            textoBotonOk: 'Guardar',
            textoBotonCancelar: 'Cancelar',
            onOk: botonActivo
                ? () async {
                    try {
                      final useridStr =
                          await SharedPreferencesHelper.getUserId();

                      if (useridStr == null) {
                        throw Exception('No se pudo obtener el ID de usuario.');
                      }
                      final userid = int.parse(useridStr);

                      final userService = UserService();
                      final user = await userService.getUserById(userid);

                      final nuevoOrder = Order(
                        descripcion: descripcionCtrl.text,
                        fechaInicio: DateTime.parse(fechaInicioCtrl.text),
                        fechaFin: DateTime.parse(fechaFinCtrl.text),
                        estado: 'PENDIENTE',
                        usuario: user,
                        etapas: [],
                      );

                      final orderService = OrderService();
                      final mensaje =
                          await orderService.createOrder(nuevoOrder);

                      print('Respuesta backend: $mensaje');
                      Navigator.of(context).pop();
                      onOrderCreado();
                    } catch (e) {
                      print('Error al crear nueva orden: $e');
                    }
                  }
                : null,
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
