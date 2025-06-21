import 'package:flutter/material.dart';
import 'package:frontend/models/specialty/specialty.dart';
import 'package:frontend/services/specialties/specialty_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/helper/input_form_field.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

class SpecialtyFormScreen extends StatefulWidget {
  final Specialty? specialty;
  final VoidCallback onGuardado;

  const SpecialtyFormScreen({Key? key, this.specialty, required this.onGuardado}) : super(key: key);

  @override
  State<SpecialtyFormScreen> createState() => _SpecialtyFormScreenState();
}

class _SpecialtyFormScreenState extends State<SpecialtyFormScreen> {
  final _nombreCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();

  bool _isLoading = false;
  bool _botonActivo = false;

  @override
  void initState() {
    super.initState();
    if (widget.specialty != null) {
      _nombreCtrl.text = widget.specialty!.nombre;
      _descripcionCtrl.text = widget.specialty!.descripcion;
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

    final specialty = Specialty(
      nombre: _nombreCtrl.text.trim(),
      descripcion: _descripcionCtrl.text.trim(),
      id: widget.specialty?.id,
    );

    try {
      final service = SpecialtyService();
      if (widget.specialty == null) {
        await service.createSpecialty(specialty);
      } else {
        await service.updateSpecialty(widget.specialty!.id!, specialty);
      }
      if (mounted) Navigator.of(context).pop();
      widget.onGuardado();
    } catch (e) {
      debugPrint('Error al guardar especialidad: $e');
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
    final isEdit = widget.specialty != null;

    return DialogoGeneral(
      titulo: isEdit ? 'Editar Especialidad' : 'Nueva Especialidad',
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
      botonOkPersonalizado: _isLoading
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
              backgroundColor: AppColors.azulIntermedio,
              onPressed: () => Navigator.of(context).pop(),
            ),
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
