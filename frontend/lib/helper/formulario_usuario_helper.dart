import 'package:flutter/material.dart';
import 'package:frontend/helper/input_form_field.dart';

Widget buildFormularioUsuario({
  required TextEditingController nombreCtrl,
  required TextEditingController correoCtrl,
  required TextEditingController passwordCtrl,
  required TextEditingController telefonoCtrl,
  required TextEditingController direccionCtrl,
  required bool isPasswordVisible,
  required VoidCallback onTogglePassword,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      inputFormField(
        label: 'Nombre',
        hint: 'Ingrese el nombre',
        controller: nombreCtrl,
      ),
      const SizedBox(height: 15),
      inputFormField(
        label: 'Correo Electrónico',
        hint: 'Ingrese el correo',
        controller: correoCtrl,
      ),
      const SizedBox(height: 15),
      inputFormField(
        label: 'Contraseña',
        hint: 'Ingrese la contraseña',
        controller: passwordCtrl,
        isPassword: true,
        passwordVisible: isPasswordVisible,
        onTogglePassword: onTogglePassword,
      ),
      const SizedBox(height: 15),
      inputFormField(
        label: 'Teléfono',
        hint: 'Ingrese el teléfono',
        controller: telefonoCtrl,
      ),
      const SizedBox(height: 15),
      inputFormField(
        label: 'Dirección',
        hint: 'Ingrese la dirección',
        controller: direccionCtrl,
      ),
    ],
  );
}
