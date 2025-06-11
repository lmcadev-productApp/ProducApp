class Stage {
  final int? id; // Opcional y sólo para referencia interna
  final String nombre;
  final String descripcion;

  Stage({
    this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      // NO incluimos 'id' aquí nunca
    };
  }
}
