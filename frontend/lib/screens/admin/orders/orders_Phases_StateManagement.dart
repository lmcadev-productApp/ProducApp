import 'package:flutter/material.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/services/orders/Order_Service.dart';
import 'package:frontend/widgets/buttons/customizable_modal_options.dart';
import 'package:frontend/widgets/dialogs/admin/order/delete_order_dialog.dart';
import 'package:frontend/widgets/dialogs/admin/order/edit_order_dialog.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/lists/admin/order/order_list.dart';
import 'package:frontend/widgets/searches/search_input.dart';
import 'package:frontend/widgets/dialogs/admin/order/assign_stages_dialog.dart';




class AdminOrdersPhaseStateManagement extends StatefulWidget {
  @override
  _AdminOrdersPhaseStateManagement createState() =>
      _AdminOrdersPhaseStateManagement();
}

class _AdminOrdersPhaseStateManagement extends State<AdminOrdersPhaseStateManagement> {
  final OrderService orderService = OrderService();
  List<WorkOrders> ordenes = [];
  List<WorkOrders> ordenesFiltradas = [];
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
      List<WorkOrders> lista = await orderService.getOrdersByEstado('PENDIENTE');
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
            order.descripcion.toLowerCase().contains(query.toLowerCase()) ||
            order.usuario.nombre.toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        ordenesFiltradas = filtradas;
      });
    }
  }

  void mostrarOpcionesOrden(BuildContext context, dynamic order) {
    ModalOptionsCustomizable.mostrar(
      context: context,
      titulo: 'Orden: ${order.id}',
      acciones: [
        AccionModal(
          icono: Icons.edit,
          titulo: 'Editar',
          alPresionar: () {
            mostrarEditarOrden(context, order, () {
              cargarOrdenes();
            });
          },
        ),
        AccionModal(
          icono: Icons.delete,
          titulo: 'Eliminar',
          alPresionar: () {
            mostrarDialogoEliminar(context, order);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      titulo: 'Asignar etapas a Ordenes',
      contenidoPersonalizado: Column(
        children: [
          SearchInput(
            hintText: 'Buscar Orden...',
            espacioInferior: true,
            controller: searchController,
          ),

          Expanded(
            child: ListOrder(
              orders: ordenesFiltradas,
              onTap: (order) async{

                print('Orden seleccionada: ${order.usuario.nombre}');
                await mostrarFormularioAsignarEtapas(context, order);
              },
              onLongPress: (order) {
                mostrarOpcionesOrden(context, order);
              },
            ),
          ),
        ],
      ),
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
