import 'package:flutter/material.dart';
import 'package:frontend/helper/confirm_delete_helper.dart';
import 'package:frontend/helper/snackbar_helper.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/services/orders/Order_Service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/buttons/customizable_modal_options.dart';
import 'package:frontend/widgets/dialogs/admin/order/delete_order_dialog.dart';
import 'package:frontend/widgets/dialogs/admin/order/edit_order_dialog.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/lists/admin/order/order_list.dart';
import 'package:frontend/widgets/searches/search_input.dart';
import 'package:frontend/widgets/dialogs/admin/order/add_order_dialog.dart';

class AdminOrderStateManagement extends StatefulWidget {
  @override
  _AdminOrderStateManagementState createState() =>
      _AdminOrderStateManagementState();
}

class _AdminOrderStateManagementState extends State<AdminOrderStateManagement> {
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
      List<WorkOrders> lista = await orderService.getOrders();
      if (lista.any((e) => e == null)) {
        debugPrint('⚠️ Lista contiene elementos nulos');
      }

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
      titulo: 'Gestión de Órdenes',
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab_usuarios',
        onPressed: () {
          mostrarAgregarOrderVisual(context, () {
            cargarOrdenes();
          });
        },
        child: const Icon(Icons.add),
      ),
      contenidoPersonalizado: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SearchInput(
              hintText: 'Buscar Orden...',
              espacioInferior: true,
              controller: searchController,
            ),
            const SizedBox(height: 8),
            Expanded( // 👈 Esto permite que ListOrder use scroll sin conflicto
              child: ListOrder(
                orders: ordenesFiltradas,
                onTap: (order) {
                  print('Orden seleccionada: ${order.usuario.nombre}');
                },
                onEdit: (order) {
                  mostrarEditarOrden(context, order, () {
                    cargarOrdenes();
                  });
                },
                  onDelete: (order) {
                    confirmarEliminacion(
                      context: context,
                      titulo: 'Eliminar Orden',
                      mensaje: '¿Estás seguro de que deseas eliminar la orden #${order.id}?',
                      mensajeExito: 'Orden eliminada correctamente 🗑️',
                      mensajeError: 'No se pudo eliminar la orden ❌',
                      onDelete: () async {
                        await OrderService().deleteOrder(order.id!);
                        cargarOrdenes();
                      },
                    );
                  },

                  onEdicionExitosa: () {
                  showCustomSnackBar(context, 'Orden editada correctamente ✏️');
                },
                mostrarAsignarEtapas: false,
              ),
            ),
          ],
        ),
      ),



      colorHeader: AppColors.azulIntermedio,
    );
  }
}


