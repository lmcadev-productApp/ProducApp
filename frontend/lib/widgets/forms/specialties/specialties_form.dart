import 'package:flutter/material.dart';
import 'package:frontend/models/specialty/specialty.dart';
import 'package:frontend/services/specialties/specialty_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/utils/app_text_styles.dart';
import 'package:frontend/widgets/common/custom_text_field.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';

class SpecialtyFormScreen extends StatefulWidget {
  final Specialty? specialty;

  const SpecialtyFormScreen({Key? key, this.specialty}) : super(key: key);

  @override
  _SpecialtyFormScreenState createState() => _SpecialtyFormScreenState();
}

class _SpecialtyFormScreenState extends State<SpecialtyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _specialtyService = SpecialtyService();

  @override
  void initState() {
    super.initState();
    if (widget.specialty != null) {
      _nombreController.text = widget.specialty!.nombre;
      _descripcionController.text = widget.specialty!.descripcion;
    }
  }

  void _saveSpecialty() async {
    if (_formKey.currentState!.validate()) {
      final newSpecialty = Specialty(
        id: widget.specialty?.id ?? 0,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
      );

      try {
        if (widget.specialty == null) {
          await _specialtyService.createSpecialty(newSpecialty);
        } else {
          await _specialtyService.updateSpecialty(
              widget.specialty!.id, newSpecialty);
        }

        Navigator.pop(context, true);
      } catch (e) {
        print('Error guardando especialidad: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error guardando especialidad')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.specialty != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Editar Especialidad' : 'Nueva Especialidad',
          style: AppTextStyles.tituloHeader,
        ),
        iconTheme: const IconThemeData(color: AppColors.blanco),
        backgroundColor: AppColors.azulIntermedio,
        elevation: 20,
      ),
      body: Container(
        color: AppColors.azulClaroFondo,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre', style: AppTextStyles.inputLabel),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _nombreController,
                  label: 'Ingrese un nombre',
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese un nombre' : null,
                ),
                const SizedBox(height: 24),
                Text('Descripción', style: AppTextStyles.inputLabel),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _descripcionController,
                  label: 'Ingrese una descripción',
                  maxLines: 3,
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese una descripción' : null,
                ),
                const SizedBox(height: 40),
                Center(
                  child: PrimaryButton(
                    text: isEdit ? 'Actualizar' : 'Guardar',
                    onPressed: _saveSpecialty,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
