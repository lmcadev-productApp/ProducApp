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
