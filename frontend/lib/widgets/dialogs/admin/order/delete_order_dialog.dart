import 'package:flutter/material.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/services/orders/Order_Service.dart';

import 'package:frontend/widgets/dialogs/dialog_general.dart'; // Ajusta el import según tu proyecto

void alPresionarEliminar(
    BuildContext context, WorkOrders order, VoidCallback onOrderEliminado) async {
  final idAEliminar = await mostrarDialogoEliminar(context, order);
  if (idAEliminar != null) {
    try {
      await OrderService().deleteOrder(idAEliminar);
      print('Orden eliminado: $idAEliminar');
      onOrderEliminado(); // refresca la lista después de eliminar
    } catch (e) {
      String mensajeError = 'Error al eliminar orden.';
      if (e.toString().contains('409') ||
          e.toString().toLowerCase().contains('foreign key')) {
        mensajeError =
            'No se puede eliminar la orden porque tiene registros relacionados.';
      }
      await DialogoHelper.mostrarError(
        context,
        titulo:
            'Error No se puede eliminar la orden porque tiene registros relacionados.',
        mensaje: mensajeError,
      );
    }
  }
}

Future<int?> mostrarDialogoEliminar(BuildContext context, WorkOrders order) async {
  final resultado = await DialogoHelper.mostrarConfirmacion(
    context,
    titulo: 'Eliminar orden',
    mensaje: '¿Estás seguro de eliminar la orden "${order.id}"?',
    textoOk: 'Eliminar',
    textoCancelar: 'Cancelar',
    color: Colors.red,
  );

  if (resultado == true) {
    return order.id;
  } else {
    return null;
  }
}
