import 'package:flutter/material.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/dialogs/admin/order/assign_stages_dialog.dart'
    show mostrarFormularioAsignarEtapas;

class ListOrder extends StatelessWidget {
  final List<WorkOrders> orders;
  final Function(WorkOrders)? onTap;
  final Function(WorkOrders)? onLongPress;
  final Function(WorkOrders)? onEdit;
  final Function(WorkOrders)? onDelete;
  final Function(WorkOrders)? onAsignarOperario;
  final bool mostrarAsignarEtapas;
  final Function(WorkOrders)? onAsignacionExitosa;
  final VoidCallback? onEdicionExitosa;


  const ListOrder({
    Key? key,
    required this.orders,
    this.onTap,
    this.onLongPress,
    this.onEdit,
    this.onDelete,
    this.mostrarAsignarEtapas = false,
    this.onAsignarOperario,
    this.onAsignacionExitosa,
    this.onEdicionExitosa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: orders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(context, order);
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, WorkOrders order) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Descripción + etiqueta Orden
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    order.descripcion,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.azulClaro,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Orden',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Fechas + ID alineado con fechaFin
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Inicio: ${order.fechaInicio != null ? _formatearFecha(order.fechaInicio!) : 'N/A'}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fin: ${order.fechaFin != null ? _formatearFecha(order.fechaFin!) : 'N/A'}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      Text(
                        'ID: ${order.id ?? '-'}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Estado + botones a la derecha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Estado: ', style: TextStyle(fontSize: 14)),
                    _buildEstadoBadge(order.estado),
                  ],
                ),
                Row(
                  children: [
                    if (onEdit != null)
                      IconButton(
                        icon: const Icon(Icons.edit, color: AppColors.verdeCheck),
                        onPressed: () async {
                          onEdit!(order);
                          onEdicionExitosa?.call();
                        },
                        tooltip: 'Editar orden',
                      ),
                    if (onDelete != null)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          onDelete!(order);
                        },
                        tooltip: 'Eliminar orden',
                      ),
                    if (onAsignarOperario != null)
                      IconButton(
                        icon: const Icon(Icons.assignment_turned_in_outlined, color: Colors.red),
                        onPressed: () async {
                          onAsignarOperario!(order);
                        },
                        tooltip: 'Asignar Operario',
                      ),
                  ],
                ),
              ],
            ),

            // Etapas
            if (order.etapas.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text('🧱 Etapas:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              ...order.etapas.map((etapa) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_right, size: 18),
                    Expanded(
                      child: Text(
                        '${etapa.etapa.nombre} → ${etapa.estado}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              )),
            ],

            // Botón Asignar Etapas (solo si se debe mostrar)
            if (mostrarAsignarEtapas) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await mostrarFormularioAsignarEtapas(context, order);
                  },
                  icon: const Icon(Icons.assignment_turned_in_outlined),
                  label: const Text('Asignar Etapas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.verdeCheck,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ]

          ],
        ),
      ),
    );
  }


  Widget _buildHeader(WorkOrders order) {
    return Row(
      children: [
        Expanded(
          child: Text(
            order.descripcion,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.azulClaro,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Orden',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildFechas(WorkOrders order) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Inicio: ${order.fechaInicio != null ? _formatearFecha(order.fechaInicio!) : 'N/A'}',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        Expanded(
          child: Text(
            'Fin: ${order.fechaFin != null ? _formatearFecha(order.fechaFin!) : 'N/A'}',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  Widget _buildEstadoBadge(String estado) {
    Color color;
    switch (estado.toUpperCase()) {
      case 'ACTIVO':
        color = Colors.green;
        break;
      case 'INACTIVO':
        color = Colors.red;
        break;
      case 'PENDIENTE':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        estado,
        style: TextStyle(
          fontSize: 13,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }


  Widget _buildOrderId(WorkOrders order) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'ID: ${order.id}',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }

  String _formatearFecha(DateTime fecha) {
    return '${fecha.year}-${_dosDigitos(fecha.month)}-${_dosDigitos(fecha.day)}';
  }

  String _dosDigitos(int valor) {
    return valor.toString().padLeft(2, '0');
  }
}
