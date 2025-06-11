import 'package:flutter/material.dart';
import 'package:frontend/models/stages/stage.dart';
import 'package:frontend/services/stages/stage_service.dart';
import 'package:frontend/widgets/searches/search_input.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/stages/stages_form.dart'; // Asegúrate de importar el formulario

class StagesScreen extends StatefulWidget {
  @override
  _StagesScreenState createState() => _StagesScreenState();
}

class _StagesScreenState extends State<StagesScreen> {
  final StageService _stageService = StageService();
  List<Stage> etapas = []; // Lista original
  List<Stage> etapasFiltradas = []; // Lista filtrada para mostrar
  TextEditingController searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStages();
    searchController.addListener(() {
      _filterStages(searchController.text);
    });
  }

  void _loadStages() async {
    try {
      final stages = await _stageService.getAllStages();
      setState(() {
        etapas = stages;
        etapasFiltradas = stages;
        _filterStages(searchController.text); // vuelve a aplicar filtro
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  void _filterStages(String query) {
    final filtered = etapas.where((stage) {
      final nombre = stage.nombre.toLowerCase();
      final descripcion = stage.descripcion.toLowerCase();
      final input = query.toLowerCase();

      return nombre.contains(input) || descripcion.contains(input);
    }).toList();

    setState(() {
      etapasFiltradas = filtered;
    });
  }

  void _deleteStage(int id) async {
    try {
      await _stageService.deleteStage(id);
      _loadStages();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Etapa eliminada'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error al eliminar etapa: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al eliminar etapa'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(stage == null ? 'Etapa creada' : 'Etapa actualizada'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      titulo: 'Gestión de Etapas',
      contenido: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: SearchInput(
                    hintText: 'Buscar Etapa...',
                    espacioInferior: true,
                    controller: searchController,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: etapasFiltradas.length,
                    itemBuilder: (context, index) {
                      final stage = etapasFiltradas[index];
                      return ListTile(
                        title: Text(stage.nombre),
                        subtitle: Text(stage.descripcion),
                        onTap: () => _navigateToForm(stage: stage),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteStage(stage.id!),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () => _navigateToForm(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
