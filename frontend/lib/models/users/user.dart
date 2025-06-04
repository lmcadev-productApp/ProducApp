import 'package:frontend/models/specialty/specialty.dart';

class User {
  final int id;
  final String correo;
  final String contrasena;
  final String rol;
  final String nombre;
  final String telefono;
  final String direccion;
  final Specialty especialidad;
  final String suguroSocial;
  final String arl;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      correo: json['correo'] ?? '',
      contrasena: json['contrasena'] ?? '',
      rol: json['rol'] ?? '',
      nombre: json['nombre'] ?? '',
      telefono: json['telefono'] ?? '',
      direccion: json['direccion'] ?? '',
      especialidad: Specialty.fromJson(json['especialidad'] ?? {}),
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
