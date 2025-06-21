
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
    print('Datos recibidos en ProductionStage.fromJson: $json');

    return ProductionStage(
      id: json['id'],
      estado: json['estado'] ?? 'PENDIENTE', // Valor por defecto si es null
      fechaInicio: json['fechaInicio'] != null ? DateTime.tryParse(json['fechaInicio']) : null,
      fechaFin: json['fechaFin'] != null ? DateTime.tryParse(json['fechaFin']) : null,
      workOrders: WorkOrders.fromJson(json['ordenTrabajo']),
      etapaId: json['etapa'] != null
          ? Stage.fromJson(json['etapa'])
          : Stage(id: 0, nombre: 'Sin etapa', descripcion: 'No disponible'),
      user: json['usuario'] != null ? User.fromJson(json['usuario']) : null,
      registradoPorId: json['registradoPor']?['id'] ?? 0,
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estado': estado,
      'fechaInicio': fechaInicio?.toIso8601String(),
      'fechaFin': fechaFin?.toIso8601String(),
      'ordenTrabajo': workOrders.toJson(),
      'etapa': etapaId.toJson(),
      'usuario': user?.toJson(),
      'registradoPor': {'id': registradoPorId},
    };
  }

}
