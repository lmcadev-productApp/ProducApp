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
      id: json['id'],
      correo: json['correo'] ?? '',
      contrasena: json['contrasena'] ?? '',
      rol: json['rol'],
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

  User copyWith({
    int? id,
    String? correo,
    String? contrasena,
    String? rol,
    String? nombre,
    String? telefono,
    String? direccion,
    Specialty? especialidad,
    String? suguroSocial,
    String? arl,
  }) {
    return User(
      id: id ?? this.id,
      correo: correo ?? this.correo,
      contrasena: contrasena ?? this.contrasena,
      rol: rol ?? this.rol,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      direccion: direccion ?? this.direccion,
      especialidad: especialidad ?? this.especialidad,
      suguroSocial: suguroSocial ?? this.suguroSocial,
      arl: arl ?? this.arl,
    );
  }
}
