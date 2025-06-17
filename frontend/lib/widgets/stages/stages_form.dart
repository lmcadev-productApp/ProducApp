import 'package:flutter/material.dart';
import 'package:frontend/models/stages/stage.dart';
import 'package:frontend/services/stages/stage_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/utils/app_text_styles.dart';
import 'package:frontend/widgets/common/custom_text_field.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';


class StageFormScreen extends StatefulWidget {
  final Stage? stage;

  const StageFormScreen({Key? key, this.stage}) : super(key: key);

  @override
  _StageFormScreenState createState() => _StageFormScreenState();
}

class _StageFormScreenState extends State<StageFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _stageService = StageService();

  @override
  void initState() {
    super.initState();
    if (widget.stage != null) {
      _nombreController.text = widget.stage!.nombre;
      _descripcionController.text = widget.stage!.descripcion;
    }
  }

  void _saveStage() async {
    if (_formKey.currentState!.validate()) {
      final newStage = Stage(
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
      );

      try {
        if (widget.stage == null) {
          await _stageService.createStage(newStage);
        } else {
          await _stageService.updateStage(widget.stage!.id!, newStage);
        }

        Navigator.pop(context, true);
      } catch (e) {
        print('Error guardando etapa: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error guardando etapa')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.stage != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? 'Editar Etapa' : 'Nueva Etapa',
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
                  validator: (value) => value!.isEmpty ? 'Ingrese un nombre' : null,
                ),
                const SizedBox(height: 24),
                Text('Descripción', style: AppTextStyles.inputLabel),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _descripcionController,
                  label: 'Ingrese una descripción',
                  maxLines: 3,
                  validator: (value) => value!.isEmpty ? 'Ingrese una descripción' : null,
                ),
                const SizedBox(height: 40),
                Center(
                  child: PrimaryButton(
                    text: isEdit ? 'Actualizar' : 'Guardar',
                    onPressed: _saveStage,
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
