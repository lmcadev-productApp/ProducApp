import 'package:flutter/material.dart';
import '../models/stages/stage.dart';
import '../services/stage_service.dart';
import 'stage_form_screen.dart'; // Asegúrate de importar el formulario

class StagesScreen extends StatefulWidget {
  @override
  _StagesScreenState createState() => _StagesScreenState();
}

class _StagesScreenState extends State<StagesScreen> {
  final StageService _stageService = StageService();
  List<Stage> _stages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStages();
  }

  void _loadStages() async {
    try {
      final stages = await _stageService.getAllStages();
      setState(() {
        _stages = stages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  void _deleteStage(int id) async {
    await _stageService.deleteStage(id);
    _loadStages();
  }

  void _navigateToForm({Stage? stage}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StageFormScreen(stage: stage),
      ),
    );

    if (result == true) {
      _loadStages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Etapas')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _stages.length,
        itemBuilder: (context, index) {
          final stage = _stages[index];
          return ListTile(
            title: Text(stage.nombre),
            subtitle: Text(stage.descripcion),
            onTap: () => _navigateToForm(stage: stage), // Editar
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteStage(stage.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _navigateToForm(), // Crear
      ),
    );
  }
}
