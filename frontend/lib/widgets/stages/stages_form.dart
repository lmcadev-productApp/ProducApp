import 'package:flutter/material.dart';
import '../../models/stages/stage.dart';
import '../../services/stage_service.dart';

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
        id: widget.stage?.id ?? 0,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
      );

      try {
        if (widget.stage == null) {
          await _stageService.createStage(newStage);
        } else {
          await _stageService.updateStage(widget.stage!.id, newStage);
        }

        Navigator.pop(context, true); // return true to indicate success
      } catch (e) {
        print('Error guardando etapa: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.stage != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar Etapa' : 'Nueva Etapa')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                value!.isEmpty ? 'Ingrese un nombre' : null,
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) =>
                value!.isEmpty ? 'Ingrese una descripción' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStage,
                child: Text(isEdit ? 'Actualizar' : 'Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
