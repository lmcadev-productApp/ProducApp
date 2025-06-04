import 'package:frontend/models/users/user.dart';
import 'package:frontend/models/stages/stage_order.dart';

class TechnicalFile {
  final int id;
  final String nombre;
  final String url;
  final User usuario;
  final StageOrder etapaProduccion;

  TechnicalFile({
    required this.id,
    required this.nombre,
    required this.url,
    required this.usuario,
    required this.etapaProduccion,
  });

  factory TechnicalFile.fromJson(Map<String, dynamic> json) {
    return TechnicalFile(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      url: json['url'] ?? '',
      usuario: User.fromJson(json['usuario'] ?? {}),
      etapaProduccion: StageOrder.fromJson(json['etapaProduccion'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'url': url,
      'usuario': usuario.toJson(),
      'etapaProduccion': etapaProduccion.toJson(),
    };
  }
}
