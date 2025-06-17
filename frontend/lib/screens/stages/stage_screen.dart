import 'package:flutter/material.dart';
import 'package:frontend/helper/confirm_delete_helper.dart';
import 'package:frontend/helper/snackbar_helper.dart';
import 'package:frontend/models/stages/stage.dart';
import 'package:frontend/services/stages/stage_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/searches/search_input.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/stages/stages_form.dart';

class StagesScreen extends StatefulWidget {
  const StagesScreen({super.key});

  @override
  _StagesScreenState createState() => _StagesScreenState();
}

class _StagesScreenState extends State<StagesScreen> {
  final StageService _stageService = StageService();
  List<Stage> etapas = [];
  List<Stage> etapasFiltradas = [];
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
        _filterStages(searchController.text);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Error al cargar etapas: $e');
    }
  }

  void _filterStages(String query) {
    final input = query.toLowerCase();
    final filtered = etapas.where((stage) {
      return stage.nombre.toLowerCase().contains(input) ||
          stage.descripcion.toLowerCase().contains(input);
    }).toList();

    setState(() => etapasFiltradas = filtered);
  }

  void _navigateToForm({Stage? stage}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StageFormScreen(stage: stage),
      ),
    );

    if (result == true) {
      _loadStages();
      showCustomSnackBar(
          context, stage == null ? 'Etapa creada' : 'Etapa actualizada');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen<Stage>(
      titulo: 'Gestión de Etapas',
      items: etapasFiltradas,
      tituloItem: (stage) => stage.nombre,
      subtituloItem: (stage) => stage.descripcion,
      onEdit: (stage) => _navigateToForm(stage: stage),
      onDelete: (stage, context) {
        confirmarEliminacion(
          context: context,
          onDelete: () async {
            await _stageService.deleteStage(stage.id!);
            _loadStages();
          },
          mensajeConfirmacion: '¿Deseas eliminar esta etapa?',
          mensajeExito: 'Etapa eliminada',
          mensajeError: 'Error al eliminar etapa',
        );
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
      topContent: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SearchInput(
          hintText: 'Buscar Etapa...',
          espacioInferior: true,
          controller: searchController,
        ),
      ),
      colorHeader: AppColors.azulIntermedio,
    );
  }
}