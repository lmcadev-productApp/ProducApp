import 'package:flutter/material.dart';
import 'package:frontend/helper/snackbar_helper.dart' show showCustomSnackBar;
import 'package:frontend/models/productionStages/productionStages.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/productionStages/productionStages_Service.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/utils/AppColors.dart' show AppColors;
import 'package:frontend/utils/app_text_styles.dart';
import 'package:frontend/utils/role_color.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:intl/intl.dart';

Future<void> mostrarFormularioAsignarEtapasAOperario(
    BuildContext context,
    ProductionStage etapa,
    ) async {
  final operarios = await UserService().getUsers();
  User? seleccionado;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: StatefulBuilder(
        builder: (context, setState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.azulIntermedio,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Asignar operario • Orden #${etapa.workOrders.id}',
                      style: AppTextStyles.tituloHeader.copyWith(color: Colors.white),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // ───── Selector de operario ─────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: DropdownButtonFormField<User>(
                decoration: InputDecoration(
                  labelText: 'Selecciona un operario',
                  labelStyle: AppTextStyles.inputLabel,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.azulIntermedio, width: 1.4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.azulIntermedio, width: 2),
                  ),
                ),
                dropdownColor: Colors.white,
                isExpanded: true,
                value: seleccionado,
                items: operarios.map((u) {
                  final especialidad = u.especialidad?.nombre ?? 'Sin especialidad';
                  final color = getEspecialidadColor(especialidad);

                  return DropdownMenuItem<User>(
                    value: u,
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: color,
                        child: Text(
                          especialidad.isNotEmpty ? especialidad[0].toUpperCase() : '?',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(u.nombre, style: AppTextStyles.inputText),
                      subtitle: Text(especialidad, style: AppTextStyles.inputHint),
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (context) {
                  return operarios.map((u) {
                    return Text(u.nombre, style: AppTextStyles.inputText);
                  }).toList();
                },
                onChanged: (u) => setState(() => seleccionado = u),
              ),
            ),

            const SizedBox(height: 28),

            // ───── Botones ─────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Cancelar',
                      backgroundColor: AppColors.azulIntermedio,
                      onPressed: () => Navigator.pop(context),
                      fontSize: 16,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Asignar',
                      isEnabled: seleccionado != null,
                      onPressed: seleccionado == null
                          ? null
                          : () async {
                        final fechaHoy = DateFormat('yyyy-MM-dd').format(DateTime.now());

                        try {
                          await ProductionStageService().asignarOperario(
                            etapa.id!,
                            seleccionado!.id!,
                            "ASIGNADA",
                            fechaHoy,
                          );

                          if (!context.mounted) return;
                          Navigator.pop(context);
                          showCustomSnackBar(context, '✅ Operario asignado');
                        } catch (e) {
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          showCustomSnackBar(context, '❌ Error al asignar operario');
                        }
                      },
                      fontSize: 16,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
