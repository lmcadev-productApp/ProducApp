import 'package:flutter/material.dart';
import 'package:frontend/models/stages/stage.dart';
import 'package:frontend/services/stages/stage_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/helper/input_form_field.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

class StageFormScreen extends StatefulWidget {
  final Stage? stage;              // null ⇒ crear, distinto de null ⇒ editar
  final VoidCallback onGuardado;   // callback para refrescar la lista

  const StageFormScreen({Key? key, this.stage, required this.onGuardado})
      : super(key: key);

  @override
  State<StageFormScreen> createState() => _StageFormScreenState();
}

class _StageFormScreenState extends State<StageFormScreen> {
  final _nombreCtrl      = TextEditingController();
  final _descripcionCtrl = TextEditingController();

  bool _isLoading   = false;
  bool _botonActivo = false;

  @override
  void initState() {
    super.initState();
    if (widget.stage != null) {
      _nombreCtrl.text      = widget.stage!.nombre;
      _descripcionCtrl.text = widget.stage!.descripcion;
    }
    _updateButtonState();
    _nombreCtrl.addListener(_updateButtonState);
    _descripcionCtrl.addListener(_updateButtonState);
  }

  void _updateButtonState() => setState(() {
    _botonActivo = _nombreCtrl.text.trim().isNotEmpty &&
        _descripcionCtrl.text.trim().isNotEmpty;
  });

  Future<void> _guardar() async {
    if (!_botonActivo || _isLoading) return;

    setState(() => _isLoading = true);
    final stage = Stage(
      nombre: _nombreCtrl.text.trim(),
      descripcion: _descripcionCtrl.text.trim(),
    );

    try {
      final service = StageService();
      if (widget.stage == null) {
        await service.createStage(stage);
      } else {
        await service.updateStage(widget.stage!.id!, stage);
      }
      if (mounted) Navigator.of(context).pop();
      widget.onGuardado();
    } catch (e) {
      debugPrint('Error al guardar etapa: $e');
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.stage != null;

    return DialogoGeneral(
      titulo: isEdit ? 'Editar Etapa' : 'Nueva Etapa',
      contenido: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputFormField(
              label: 'Nombre',
              hint: 'Ingrese un nombre',
              controller: _nombreCtrl,
            ),
            const SizedBox(height: 16),
            inputFormField(
              label: 'Descripción',
              hint: 'Ingrese una descripción',
              controller: _descripcionCtrl,
              maxLines: 3,
            ),
          ],
        ),
      ),

      // ─── Botones personalizados ──────────────────────────────────────────
      botonOkPersonalizado: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
        child: Wrap(
          spacing: 14,
          children: [
            // Cancelar
            PrimaryButton(
              text: 'Cancelar',
              width: 135,
              height: 48,
              fontSize: 16,
              backgroundColor: AppColors.azulIntermedio,
              onPressed: () => Navigator.of(context).pop(),
            ),

            // Guardar / Actualizar
            PrimaryButton(
              text: isEdit ? 'Actualizar' : 'Guardar',
              width: 135,
              height: 48,
              fontSize: 16,
              isEnabled: _botonActivo,
              backgroundColor: _botonActivo
                  ? AppColors.azulIntermedio
                  : AppColors.grisTextoSecundario,
              onPressed: _guardar,
            ),
          ],
        ),
      ),
    );
  }
}
