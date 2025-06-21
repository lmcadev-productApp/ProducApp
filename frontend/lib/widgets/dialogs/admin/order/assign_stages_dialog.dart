import 'package:flutter/material.dart';
import 'package:frontend/helper/snackbar_helper.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/models/stages/stage.dart';
import 'package:frontend/services/stages/stage_service.dart';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:frontend/utils/AppColors.dart' show AppColors;
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

Future<void> mostrarFormularioAsignarEtapas(
    BuildContext context, WorkOrders order) async {
  final stageService = StageService();
  final List<Stage> stageAvailable = await stageService.getAllStages();
  final userId = await SharedPreferencesHelper.getUserId();

  showDialog(
    context: context,
    builder: (context) {
      Set<int> stageSelected = {};
      bool isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return DialogoGeneral(
            titulo: 'Asignar Etapas - Orden #${order.id}',
            contenido: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: stageAvailable.length,
                itemBuilder: (context, index) {
                  final stage = stageAvailable[index];
                  return CheckboxListTile(
                    title: Text(stage.nombre),
                    subtitle: stage.descripcion != null &&
                        stage.descripcion!.isNotEmpty
                        ? Text(stage.descripcion!)
                        : null,
                    value: stageSelected.contains(stage.id),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          stageSelected.add(stage.id!);
                        } else {
                          stageSelected.remove(stage.id);
                        }
                      });
                    },
                  );
                },
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
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    backgroundColor: AppColors.azulIntermedio,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  PrimaryButton(
                    text: 'Asignar',
                    isEnabled: stageSelected.isNotEmpty,
                    width: 135,
                    height: 48,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    backgroundColor: stageSelected.isNotEmpty
                        ? AppColors.azulIntermedio
                        : AppColors.grisTextoSecundario,
                    onPressed: () {
                    () async {
                      setState(() => isLoading = true);
                      try {
                        await stageService.assignStagesToOrder(
                          order.id!,
                          int.parse(userId!),
                          stageSelected.toList(),
                        );
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          showCustomSnackBar(
                            context,
                            'Etapas asignadas correctamente ✅',
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          showCustomSnackBar(
                            context,
                            'Error al asignar etapas ❌',
                            backgroundColor: Colors.redAccent,
                          );
                        }
                      } finally {
                        if (context.mounted) {
                          setState(() => isLoading = false);
                        }
                      }
                    }();
                    }
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
