import 'package:flutter/material.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/models/productionStages/productionStages.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/productionStages/productionStages_Service.dart';
import 'package:frontend/services/users/user_service.dart';



Future<void> mostrarFormularioAsignarEtapasAOperario(BuildContext context, ProductionStage etapa) async {
  List<User> operarios = await UserService().getUsers(); // necesitas ese servicio
  User? seleccionado;

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Asignar operario a orden #${etapa.workOrders.id}'),
        content: DropdownButton<User>(
          isExpanded: true,
          value: seleccionado,
          hint: Text('Selecciona un operario'),
          onChanged: (User? nuevo) {
            seleccionado = nuevo;
            Navigator.of(context).pop(); // cerrar y continuar
          },
          items: operarios.map((user) {
            return DropdownMenuItem<User>(
              value: user,
              child: Text(user.nombre),
            );
          }).toList(),
        ),
      );
    },
  );

  if (seleccionado != null) {
    await ProductionStageService().asignarOperario(etapa.id!, seleccionado!.id!);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Operario asignado')));
  }
}