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
