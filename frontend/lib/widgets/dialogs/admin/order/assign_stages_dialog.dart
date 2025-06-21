import 'package:flutter/material.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/models/stages/stage.dart';
import 'package:frontend/services/stages/stage_service.dart';

import '../../../../helper/shared_preferences_helper.dart';

Future<void> mostrarFormularioAsignarEtapas(
    BuildContext context, WorkOrders order) async {
  final stageService = StageService(); // crea este service si no lo tienes
  final List<Stage> stageAvailable = await stageService.getAllStages(); // trae de la API
  final Set<int> stageSelected = {};
  final userId = await SharedPreferencesHelper.getUserId();


  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Orden # ${order.id}'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView(
                children: stageAvailable.map((stage) {
                  return CheckboxListTile(
                    title: Text(stage.nombre),
                    subtitle: Text(stage.descripcion ?? ''),
                    value: stageSelected.contains(stage.id),
                    onChanged: (bool? value) {
                      setState(() {
                        value == true
                            ? stageSelected.add(stage.id!)
                            : stageSelected.remove(stage.id);
                      });
                    },
                  );
                }).toList(),
              ),
            );
          },
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text('Asignar'),
            onPressed: () async {
              try {
                await stageService.assignStagesToOrder(order.id!, int.parse(userId!), stageSelected.toList());
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Etapas asignadas correctamente')),
                );
              } catch (e) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al asignar etapas')),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
