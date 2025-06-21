
import 'package:frontend/models/users/user.dart';
import 'package:frontend/models/orders/order.dart';
import 'package:frontend/models/stages/stage.dart';

class ProductionStage {
  final int? id;
  final String estado;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final WorkOrders workOrders;
  final Stage etapaId;
  final User? user; // El campo 'user' puede ser nulo.
  final int registradoPorId;

  ProductionStage({
    this.id,
    required this.estado,
    this.fechaInicio,
    this.fechaFin,
    required this.workOrders,
    required this.etapaId,
    required this.user,
    required this.registradoPorId,
  });

  factory ProductionStage.fromJson(Map<String, dynamic> json) {
    return ProductionStage(
      id: json['id'],
      estado: json['estado'],
      fechaInicio: json['fechaInicio'] != null ? DateTime.parse(json['fechaInicio']) : null,
      fechaFin: json['fechaFin'] != null ? DateTime.parse(json['fechaFin']) : null,
      workOrders: WorkOrders.fromJson(json['ordenTrabajo']),
      etapaId: json['etapa']['id'], // Si 'json['etapa']' es nulo, esto causará un error.
      user: json['usuario'] != null ? User.fromJson(json['usuario']) : null,
      registradoPorId: json['registradoPor']['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'fechaInicio': fechaInicio?.toIso8601String(),
      'fechaFin': fechaFin?.toIso8601String(),
      'ordenTrabajo': workOrders.toJson(), // 'ordenTrabajo' no está definido, debería ser 'workOrders'.
      'etapa': {'id': etapaId},
      'usuario': user?.toJson(), // 'usuario' no está definido, debería ser 'user'.
      'registradoPor': {'id': registradoPorId},
    };
  }
}
