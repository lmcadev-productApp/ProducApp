class Especialidad {
  final int id;
  final String nombre;
  final String descripcion;

  Especialidad({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory Especialidad.fromJson(Map<String, dynamic> json) {
    return Especialidad(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}

class Usuario {
  final int id;
  final String correo;
  final String contrasena;
  final String rol;
  final String nombre;
  final String telefono;
  final String direccion;
  final Especialidad especialidad;
  final String suguroSocial;
  final String arl;

  Usuario({
    required this.id,
    required this.correo,
    required this.contrasena,
    required this.rol,
    required this.nombre,
    required this.telefono,
    required this.direccion,
    required this.especialidad,
    required this.suguroSocial,
    required this.arl,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] ?? 0,
      correo: json['correo'] ?? '',
      contrasena: json['contrasena'] ?? '',
      rol: json['rol'] ?? '',
      nombre: json['nombre'] ?? '',
      telefono: json['telefono'] ?? '',
      direccion: json['direccion'] ?? '',
      especialidad: Especialidad.fromJson(json['especialidad'] ?? {}),
      suguroSocial: json['suguroSocial'] ?? '',
      arl: json['arl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'correo': correo,
      'contrasena': contrasena,
      'rol': rol,
      'nombre': nombre,
      'telefono': telefono,
      'direccion': direccion,
      'especialidad': especialidad.toJson(),
      'suguroSocial': suguroSocial,
      'arl': arl,
    };
  }
}
