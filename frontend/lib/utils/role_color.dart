import 'package:flutter/material.dart';

Color getRoleColor(String? rol) {
  switch (rol) {
    case 'ADMINISTRADOR':
      return Colors.red[400]!;
    case 'SUPERVISOR':
      return Colors.orange[400]!;
    case 'OPERARIO':
      return Colors.green[400]!;
    default:
      return Colors.grey[400]!;
  }
}

Color getStageColor(String? etapa) {
  switch (etapa?.toLowerCase()) {
    case 'control de calidad':
      return Colors.deepPurpleAccent; // Color profesional
    case 'pintura':
      return Colors.pinkAccent;
    case 'corte':
      return Colors.teal;
    case 'diseno':
    case 'diseño': // soporte para ambos
      return Colors.orangeAccent;
    case 'ensamble':
      return Colors.green;
    case 'impresion':
    case 'impresión':
      return Colors.blueAccent;
    default:
      return Colors.grey; // fallback
  }

}

Color getEstadoColor(String? estado) {
  switch (estado?.toUpperCase()) {
    case 'PENDIENTE':
      return Colors.orange;
    case 'ASIGNADA':
      return Colors.pinkAccent;
    case 'EN_PROCESO':
      return Colors.blue;
    case 'COMPLETADO':
      return Colors.green;
    case 'RECHAZADO':
      return Colors.red;
    case 'PAUSADO':
      return Colors.yellowAccent;
    default:
      return Colors.grey;
  }
}


Color getEspecialidadColor(String? especialidad) {
  switch (especialidad?.toLowerCase()) {
    case 'cortador':
      return Colors.green;
    case 'diseñador':
    case 'disenador':
      return Colors.blue;
    case 'control de calidad':
      return Colors.purple;
    case 'pintor':
      return Colors.orange;
    case 'ensamblador':
      return Colors.yellow;
    case 'impresor':
      return Colors.lightBlue;
    case 'desarrollo':
      return Colors.black;
    default:
      return Colors.black26;
  }
}
