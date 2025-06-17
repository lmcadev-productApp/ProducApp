import 'package:flutter/material.dart';
import 'AppColors.dart';

class AppTextStyles {

  static const tituloHeader = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: AppColors.blanco,
  );

  static const subtitulo = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.azulLogoPrincipal,
  );

  static const cuerpo = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.negro,
  );

  static const textoSecundario = TextStyle(
    fontSize: 14,
    color: AppColors.grisTextoSecundario,
  );

  static const textoSecundarioTitulos = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.grisTextoSecundario,
  );

  static const inputText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.negro87,
  );

  static const inputLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.azulLogoPrincipal,
  );

  static const inputHint = TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
    color: Colors.grey,
  );
}
