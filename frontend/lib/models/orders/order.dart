import 'package:frontend/models/users/user.dart';
import 'package:frontend/models/stages/stage_order.dart';

class Order {
  final int id;
  final String descripcion;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final String estado;
  final User usuario;
  final List<StageOrder> etapas;

  Order({
    required this.id,
    required this.descripcion,
    this.fechaInicio,
    this.fechaFin,
    required this.estado,
    required this.usuario,
    required this.etapas,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? 0,
      descripcion: json['descripcion'] ?? '',
      fechaInicio: json['fechaInicio'] != null
          ? DateTime.parse(json['fechaInicio'])
          : null,
      fechaFin:
          json['fechaFin'] != null ? DateTime.parse(json['fechaFin']) : null,
      estado: json['estado'] ?? '',
      usuario: User.fromJson(json['usuario'] ?? {}),
      etapas: (json['etapas'] as List<dynamic>? ?? [])
          .map((e) => StageOrder.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descripcion': descripcion,
      'fechaInicio': fechaInicio?.toIso8601String(),
      'fechaFin': fechaFin?.toIso8601String(),
      'estado': estado,
      'usuario': usuario.toJson(),
      'etapas': etapas.map((e) => e.toJson()).toList(),
    };
  }
}
