import 'package:flutter/material.dart';
import 'package:frontend/models/productionStages/productionStages.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/lists/assingStageToUserList.dart';
import 'package:frontend/widgets/searches/search_input.dart';
import 'package:frontend/services/productionStages/productionStages_Service.dart';
import '../../widgets/dialogs/assignedStageDialog/assignedStageDialog.dart';




class StageList extends StatefulWidget {
  @override
  _AdminOrdersPhaseStateManagement createState() =>
      _AdminOrdersPhaseStateManagement();
}

class _AdminOrdersPhaseStateManagement extends State<StageList> {
  final ProductionStageService productionStageService = ProductionStageService();
  List<ProductionStage> ordenes = [];
  List<ProductionStage> ordenesFiltradas = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarOrdenes();

    searchController.addListener(() {
      filtrarOrdenes(searchController.text);
    });
  }

  void cargarOrdenes() async {
    try {
      List<ProductionStage> lista = await productionStageService.getStagesByUserAndStatus();
      setState(() {
        ordenes = lista;
        ordenesFiltradas = lista;
      });
    } catch (e) {
      print('Error cargando órdenes: $e');
    }
  }

  void filtrarOrdenes(String query) {
    if (query.isEmpty) {
      setState(() {
        ordenesFiltradas = ordenes;
      });
    } else {
      final filtradas = ordenes.where((order) {
        return order.id.toString().contains(query) ||
            order.workOrders.descripcion.toLowerCase().contains(query.toLowerCase()) ||
            order.etapaId.descripcion.toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        ordenesFiltradas = filtradas;
      });
    }
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Muestra el formulario para asignar operarios a las etapas de producción
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      titulo: 'Etapas Asignadas',
      contenidoPersonalizado: Column(
        children: [
          SearchInput(
            hintText: 'Buscar Orden...',
            espacioInferior: true,
            controller: searchController,
          ),
          Expanded(
            child: ListOrder(
              productionStage: ordenesFiltradas,
              mostrarAsignarUsuario: false,
              mostrarAsignarEtapa: true,
              onAsignarEtapas: (etapa) async {
                // Aquí puedes mostrar el formulario para asignar usuario
                await mostrarFormularioInformacionEtapaAsignada(context, etapa);

                // Si quieres recargar al finalizar
                cargarOrdenes();
              },

            ),
          ),
        ],
      ),
      colorHeader: AppColors.azulIntermedio,
    );
  }
}
