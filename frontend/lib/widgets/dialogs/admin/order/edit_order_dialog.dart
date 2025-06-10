import 'package:flutter/material.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/services/orders/order_service.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarEditarOrden(
    BuildContext context, Order ordenOriginal, VoidCallback onActualizada) {
  final descripcionCtrl =
      TextEditingController(text: ordenOriginal.descripcion);
  final fechaInicioCtrl = TextEditingController(
      text: ordenOriginal.fechaInicio != null
          ? ordenOriginal.fechaInicio!.toIso8601String().split('T').first
          : '');
  final fechaFinCtrl = TextEditingController(
      text: ordenOriginal.fechaFin != null
          ? ordenOriginal.fechaFin!.toIso8601String().split('T').first
          : '');
  final estadoCtrl = TextEditingController(text: ordenOriginal.estado);

  bool botonActivo = true;
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
            titulo: 'Editar orden',
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
                        initialDate:
                            ordenOriginal.fechaInicio ?? DateTime.now(),
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
                    controller: fechaInicioCtrl,
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate:
                            ordenOriginal.fechaInicio ?? DateTime.now(),
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
            textoBotonOk: 'Actualizar',
            textoBotonCancelar: 'Cancelar',
            onOk: botonActivo
                ? () async {
                    try {
                      final ordenEditada = Order(
                        id: ordenOriginal.id, // Se mantiene el mismo ID
                        descripcion: descripcionCtrl.text,
                        fechaInicio: DateTime.parse(fechaInicioCtrl.text),
                        fechaFin: DateTime.parse(fechaFinCtrl.text),
                        estado: estadoCtrl.text,
                        usuario: ordenOriginal
                            .usuario, // Se mantiene el mismo usuario
                        etapas:
                            ordenOriginal.etapas, // También las etapas actuales
                      );

                      final orderService = OrderService();
                      final mensaje = await orderService.updateOrden(
                          ordenOriginal.id, ordenEditada);

                      print('Orden actualizada: $mensaje');
                      Navigator.of(context).pop();
                      onActualizada();
                    } catch (e) {
                      print('Error al actualizar orden: $e');
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
