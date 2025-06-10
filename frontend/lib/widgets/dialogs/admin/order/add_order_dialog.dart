import 'package:flutter/material.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/services/orders/order_service.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';
import 'package:frontend/utils/shared_preferences_helper.dart';


void mostrarAgregarOrderVisual(
    BuildContext context, VoidCallback onOrderCreado) {
  final descripcionCtrl = TextEditingController();
  final fechaInicioCtrl = TextEditingController();
  final fechaFinCtrl = TextEditingController();
  final estadoCtrl = TextEditingController();

  bool botonActivo = false;
  bool listenersAgregados = false;

  void validarBoton(StateSetter setState) {
    final activo = descripcionCtrl.text.isNotEmpty &&
        estadoCtrl.text.isNotEmpty &&
        fechaInicioCtrl.text.isNotEmpty &&
        fechaFinCtrl.text.isNotEmpty;
    if (activo != botonActivo) {
      setState(() {
        botonActivo = activo;
      });
    }
  }

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          if (!listenersAgregados) {
            descripcionCtrl.addListener(() => validarBoton(setState));
            estadoCtrl.addListener(() => validarBoton(setState));
            fechaInicioCtrl.addListener(() => validarBoton(setState));
            fechaFinCtrl.addListener(() => validarBoton(setState));
            listenersAgregados = true;
          }

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
                    keyboardType: TextInputType.datetime,
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
                    keyboardType: TextInputType.datetime,
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
                  TextField(
                    controller: estadoCtrl,
                    decoration: InputDecoration(
                      hintText: 'Ingrese el estado',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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



                // obtiene ID del usuario desde SharedPreferences
                final useridStr = await SharedPreferencesHelper.getUserId();

                // Verifica que el userId no sea nulo y conviértelo a int
                if (useridStr == null) {
                  throw Exception('No se pudo obtener el ID de usuario.');
                }
                final userid = int.parse(useridStr);

                // Obtener el objeto User real usando el userId
                final userService = UserService();
                final user = await userService.getUserById(userid);

                final nuevoOrder = Order(
                  id: 0, 
                  descripcion: descripcionCtrl.text,
                  fechaInicio: DateTime.parse(fechaInicioCtrl.text),
                  fechaFin: DateTime.parse(fechaFinCtrl.text),
                  estado: estadoCtrl.text,
                  usuario: user, // Ahora se pasa el objeto User real
                  etapas: [], // A reemplazar por etapas reales si es necesario
                );

                final orderService = OrderService();
                final mensaje =
                await orderService.createOrder(nuevoOrder);

                print('Respuesta backend: $mensaje');
                Navigator.of(context).pop();
                onOrderCreado();
              } catch (e) {
                print('Error al crear nueva orden: $e');
                // Mostrar diálogo de error si es necesario
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
    estadoCtrl.dispose();
  });
}
