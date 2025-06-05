import 'package:flutter/material.dart';

Color getRoleColor(String rol) {
  switch (rol) {
    case 'Administrador':
      return Colors.red[400]!;
    case 'Supervisor':
      return Colors.orange[400]!;
    case 'Operador':
      return Colors.green[400]!;
    default:
      return Colors.grey[400]!;
  }
}
