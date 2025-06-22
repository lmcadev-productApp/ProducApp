import 'package:flutter/material.dart';
import 'package:frontend/models/productionStages/productionStages.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/lists/assingStageToUserList.dart';
import 'package:frontend/widgets/searches/search_input.dart';
import 'package:frontend/services/productionStages/productionStages_Service.dart';

import '../../widgets/dialogs/admin/productionStages/assign_user_dialog.dart';





class AssingToUser extends StatefulWidget {
  @override
  _AdminOrdersPhaseStateManagement createState() =>
      _AdminOrdersPhaseStateManagement();
}

class _AdminOrdersPhaseStateManagement extends State<AssingToUser> {
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
      List<ProductionStage> lista = await productionStageService.getAllOrdersPerStages();
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

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      titulo: 'Asignar Operario a etapas de Producción',
      colorHeader: AppColors.azulIntermedio,
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
              mostrarAsignarUsuario: true,
              onAsignarOperario: (etapa) async {
                await mostrarFormularioAsignarEtapasAOperario(context, etapa);
                cargarOrdenes();
              },
            ),
          ),
        ],
      ),

    );
  }
}