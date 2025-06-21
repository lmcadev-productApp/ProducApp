import 'package:flutter/material.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/utils/AppColors.dart';

class ListOrder extends StatelessWidget {
  final List<WorkOrders> orders;
  final Function(WorkOrders)? onTap;
  final Function(WorkOrders)? onLongPress;
  final Function(WorkOrders)? onEdit;
  final Function(WorkOrders)? onDelete;

  const ListOrder({
    Key? key,
    required this.orders,
    required this.onTap,
    this.onLongPress,
    this.onEdit,
    this.onDelete
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: orders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(WorkOrders order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap != null ? () => onTap!(order) : null,
        onLongPress: onLongPress != null ? () => onLongPress!(order) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(order),
            const SizedBox(height: 10),
            _buildFechas(order),
            const SizedBox(height: 8),
            _buildEstado(order),
            const SizedBox(height: 4),
            _buildOrderId(order),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.verdeCheck),
                    onPressed: () => onEdit!(order),
                    tooltip: 'Editar orden',
                  ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => onDelete!(order),
                    tooltip: 'Eliminar orden',
                  ),
              ],
            ),
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
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(20),
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

  Widget _buildEstado(WorkOrders order) {
    return Text(
      'Estado: ${order.estado}',
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget _buildUserName(WorkOrders order) {
    return Text(
      'Asignado a: ${order.usuario.nombre}',
      style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
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
