import 'package:flutter/material.dart';
import 'package:frontend/models/productionStages/productionStages.dart';
import 'package:frontend/utils/AppColors.dart' show AppColors;
import 'package:frontend/utils/role_color.dart' show getStageColor;
import 'package:frontend/utils/role_color.dart' show getEstadoColor;


class ListOrder extends StatelessWidget {
  final List<ProductionStage> productionStage;
  final Function(ProductionStage)? onTap;
  final Function(ProductionStage)? onLongPress;
  final bool mostrarAsignarUsuario;
  final Function(ProductionStage)? onAsignarOperario;
  final Function(ProductionStage)? onAsignacionExitosa;
  final VoidCallback? onEdicionExitosa;


  const ListOrder({
    Key? key,
    required this.productionStage,
    this.onTap,
    this.onLongPress,
    this.mostrarAsignarUsuario = false,
    this.onAsignarOperario,
    this.onAsignacionExitosa,
    this.onEdicionExitosa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: productionStage.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final order = productionStage[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(ProductionStage order) {
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
            const SizedBox(height: 6),
            _buildUserName(order),
            const SizedBox(height: 4),
            _buildOrderId(order),
          ],
        ),
      ),
    );
  }

  //Nº de orden de trabajo
  Widget _buildHeader(ProductionStage productionStage) {
    final String? nombreEtapa = productionStage.etapaId.nombre;
    final Color colorEtapa = getStageColor(nombreEtapa);

    return Row(
      children: [
        Expanded(
          child: Text(
            'Orden #: ${productionStage.workOrders.id}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colorEtapa,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            nombreEtapa ?? '',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildFechas(ProductionStage productionStage) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Descripcion: ${productionStage.workOrders.descripcion}',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        Expanded(
          child: Text(
            'Etapa: ${productionStage.etapaId.descripcion}',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  Widget _buildEstado(ProductionStage order) {
    return Text(
      'Entrega prevista: ${order.workOrders.fechaFin != null ? _formatearFecha(order.workOrders.fechaFin!) : 'No disponible'}',
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget buildEstadoBadge(String? estado) {
    final Color color = getEstadoColor(estado);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Estado: ',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color),
          ),
          child: Text(
            estado?.toUpperCase() ?? 'SIN ESTADO',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildUserName(ProductionStage productionStage) {
    final String estado = productionStage.estado ?? 'Sin estado';

    return Row(
      children: [
        buildEstadoBadge(estado), // el badge bonito
        const Spacer(), // separador flexible
        if (mostrarAsignarUsuario && onAsignarOperario != null)
          TextButton.icon(
            icon: const Icon(
              Icons.assignment_ind_outlined,
              color: AppColors.negro,
            ),
            label: const Text(
              'Asignar operario',
              style: TextStyle(color: AppColors.negro),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              backgroundColor: AppColors.azulClaroFondo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppColors.negro),
              ),
            ),
            onPressed: () => onAsignarOperario!(productionStage),
          ),
      ],
    );
  }

  Widget _buildOrderId(ProductionStage productionStage) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Etapa: ${productionStage.etapaId.nombre}',
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
