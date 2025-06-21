import 'package:flutter/material.dart';
import 'package:frontend/helper/confirm_delete_helper.dart';
import 'package:frontend/helper/snackbar_helper.dart';
import 'package:frontend/models/specialty/specialty.dart';
import 'package:frontend/services/specialties/specialty_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/forms/specialties/specialties_form.dart';
import 'package:frontend/widgets/searches/search_input.dart';
import 'package:frontend/widgets/section/section_header.dart';

class SpecialtyScreen extends StatefulWidget {
  const SpecialtyScreen({super.key});

  @override
  _SpecialtyScreenState createState() => _SpecialtyScreenState();
}

class _SpecialtyScreenState extends State<SpecialtyScreen> {
  final SpecialtyService _specialtyService = SpecialtyService();
  List<Specialty> especialidades = [];
  List<Specialty> especialidadesFiltradas = [];
  TextEditingController searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSpecialties();
    searchController.addListener(() {
      _filterSpecialties(searchController.text);
    });
  }

  void _loadSpecialties() async {
    try {
      final specialties = await _specialtyService.getAllSpecialties();
      setState(() {
        especialidades = specialties;
        especialidadesFiltradas = specialties;
        _filterSpecialties(searchController.text);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Error al cargar especialidades: $e');
    }
  }

  void _filterSpecialties(String query) {
    final input = query.toLowerCase();
    final filtered = especialidades.where((specialty) {
      return specialty.nombre.toLowerCase().contains(input) ||
          specialty.descripcion.toLowerCase().contains(input);
    }).toList();

    setState(() => especialidadesFiltradas = filtered);
  }

  void _navigateToForm({Specialty? specialty}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),  // 👈 Evita el fondo negro
      builder: (_) => SpecialtyFormScreen(
        specialty: specialty,
        onGuardado: () {
          Navigator.of(context).pop(); // Cierra el modal
          _loadSpecialties();
          ; // Refresca las etapas
          showCustomSnackBar(
            context,
            specialty == null ? 'Especialidad creada' : 'Especialidad actualizada',
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BaseScreen<Specialty>(
      titulo: 'Gestión de especialidades',
      items: especialidadesFiltradas,
      tituloItem: (specialty) => specialty.nombre,
      subtituloItem: (specialty) => specialty.descripcion,
      onEdit: (specialty) => _navigateToForm(specialty: specialty),
      onDelete: (specialty, context) {
        confirmarEliminacion(
          context: context,
          onDelete: () async {
            await _specialtyService.deleteSpecialty(specialty.id!);
            _loadSpecialties();
          },
          titulo: 'Eliminar especialidad',
          mensaje: '¿Deseas eliminar esta especialidad?',
          mensajeExito: 'Especialidad eliminada',
          mensajeError: 'Error al eliminar especialidad',
        );
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
      topContent: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SearchInput(
          hintText: 'Buscar especialidad...',
          espacioInferior: true,
          controller: searchController,
        ),
      ),
      colorHeader: AppColors.azulIntermedio,
    );
  }
}
