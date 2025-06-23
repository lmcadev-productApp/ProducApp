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

Future<void> mostrarFormularioInformacionEtapaAsignada(
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
            // ───── Encabezado ─────
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
                      'Etapa #${etapa.workOrders.id}',

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

            // ───── Selector de operaciones ─────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descripción de la orden de trabajo:',
                    style: AppTextStyles.inputLabel,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.azulIntermedio, width: 1.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${etapa.workOrders.descripcion}',
                      style: AppTextStyles.inputText,
                    ),
                  ),
                  const SizedBox(height: 20),

                ],
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
                      text: 'Iniciar',
                      isEnabled:  true,
                      onPressed:  false
                          ? null
                          : () async {

                        try {
                          await ProductionStageService().updateProductionStageToInProgress(etapa.id!);

                          if (!context.mounted) return;
                          Navigator.pop(context);
                          showCustomSnackBar(context, '✅ Etapa iniciada');
                        } catch (e) {
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          showCustomSnackBar(context, '❌ Error al iniciar etapa');
                        }
                      },
                      fontSize: 16,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Completar',
                      isEnabled: true,
                      onPressed: false
                          ? null
                          : () async {
                        final fechaHoy = DateFormat('yyyy-MM-dd').format(DateTime.now());

                        try {
                          await ProductionStageService().updateProductionStageToCompleted(etapa.id!, fechaHoy);

                          if (!context.mounted) return;
                          Navigator.pop(context);
                          showCustomSnackBar(context, '✅ Etapa completada');
                        } catch (e) {
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          showCustomSnackBar(context, '❌ Error al completar etapa');
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
