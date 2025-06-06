import 'package:frontend/models/specialty/specialty.dart';

class User {
  final int? id;
  final String correo;
  final String contrasena;
  final String? rol; // nullable
  final String nombre;
  final String telefono;
  final String direccion;
  final Specialty? especialidad; // nullable
  final String? suguroSocial; // nullable
  final String? arl; // nullable

  User({
    this.id, // opcional
    required this.correo,
    required this.contrasena,
    this.rol, // opcional
    required this.nombre,
    required this.telefono,
    required this.direccion,
    this.especialidad,
    this.suguroSocial,
    this.arl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // puede ser null
      correo: json['correo'] ?? '',
      contrasena: json['contrasena'] ?? '',
      rol: json['rol'], // puede ser null
      nombre: json['nombre'] ?? '',
      telefono: json['telefono'] ?? '',
      direccion: json['direccion'] ?? '',
      especialidad: json['especialidad'] == null
          ? null
          : Specialty.fromJson(json['especialidad']),
      suguroSocial: json['suguroSocial'],
      arl: json['arl'],
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
      'especialidad': especialidad?.toJson(),
      'suguroSocial': suguroSocial,
      'arl': arl,
    };
  }
}
