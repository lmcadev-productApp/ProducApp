import 'stage.dart';
import 'package:frontend/models/users/user.dart';

class StageOrder {
  final int id;
  final String estado;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final String ordenTrabajo;
  final Stage etapa;
  final User usuario;

  StageOrder({
    required this.id,
    required this.estado,
    this.fechaInicio,
    this.fechaFin,
    required this.ordenTrabajo,
    required this.etapa,
    required this.usuario,
  });

  factory StageOrder.fromJson(Map<String, dynamic> json) {
    return StageOrder(
      id: json['id'] ?? 0,
      estado: json['estado'] ?? '',
      fechaInicio: json['fechaInicio'] != null
          ? DateTime.parse(json['fechaInicio'])
          : null,
      fechaFin:
          json['fechaFin'] != null ? DateTime.parse(json['fechaFin']) : null,
      ordenTrabajo: json['ordenTrabajo'] ?? '',
      etapa: Stage.fromJson(json['etapa'] ?? {}),
      usuario: User.fromJson(json['usuario'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'fechaInicio': fechaInicio?.toIso8601String(),
      'fechaFin': fechaFin?.toIso8601String(),
      'ordenTrabajo': ordenTrabajo,
      'etapa': etapa.toJson(),
      'usuario': usuario.toJson(),
    };
  }
}
