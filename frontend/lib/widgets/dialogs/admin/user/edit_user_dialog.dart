import 'package:flutter/material.dart';
import 'package:frontend/helper/input_form_field.dart' show inputFormField;
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarEditarUsuario(
    BuildContext context,
    User usuario,
    VoidCallback onUsuarioActualizado,
    ) {
  final nombreCtrl    = TextEditingController(text: usuario.nombre);
  final correoCtrl    = TextEditingController(text: usuario.correo);
  final passwordCtrl  = TextEditingController(text: usuario.contrasena);
  final telefonoCtrl  = TextEditingController(text: usuario.telefono);
  final direccionCtrl = TextEditingController(text: usuario.direccion);

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {

          bool isLoading   = false;
          bool passwordVis = false;
          bool botonActivo = false;

          void _validar() {
            setState(() {
              botonActivo = nombreCtrl.text.trim().isNotEmpty &&
                  correoCtrl.text.trim().isNotEmpty &&
                  passwordCtrl.text.trim().isNotEmpty;
            });
          }

          nombreCtrl   ..removeListener(_validar)..addListener(_validar);
          correoCtrl   ..removeListener(_validar)..addListener(_validar);
          passwordCtrl ..removeListener(_validar)..addListener(_validar);
          _validar();

          return DialogoGeneral(
            titulo: 'Editar usuario',
            contenido: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  inputFormField(
                    label: 'Nombre',
                    hint : 'Ingrese el nombre',
                    controller: nombreCtrl,
                  ),
                  const SizedBox(height: 16),

                  inputFormField(
                    label: 'Correo',
                    hint : 'Ingrese el correo',
                    controller: correoCtrl,
                    tipoTeclado: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  inputFormField(
                    label: 'Contraseña',
                    hint : 'Ingrese la contraseña',
                    controller: passwordCtrl,
                    isPassword: true,
                    passwordVisible: passwordVis,
                    onTogglePassword: () =>
                        setState(() => passwordVis = !passwordVis),
                  ),
                  const SizedBox(height: 16),

                  inputFormField(
                    label: 'Teléfono',
                    hint : 'Ingrese el teléfono',
                    controller: telefonoCtrl,
                    tipoTeclado: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  inputFormField(
                    label: 'Dirección',
                    hint : 'Ingrese la dirección',
                    controller: direccionCtrl,
                  ),
                ],
              ),
            ),

            botonOkPersonalizado: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
              child: Wrap(
                spacing: 14,
                children: [
                  // CANCELAR
                  PrimaryButton(
                    text: 'Cancelar',
                    width: 135,
                    height: 48,
                    fontSize: 16,
                    backgroundColor: AppColors.azulIntermedio,
                    onPressed: () => Navigator.of(context).pop(),
                  ),

                  PrimaryButton(
                    text: 'Guardar',
                    width: 135,
                    height: 48,
                    fontSize: 16,
                    isEnabled: botonActivo,
                    backgroundColor: botonActivo
                        ? AppColors.azulIntermedio
                        : AppColors.grisTextoSecundario,

                    onPressed: () {
                      if (!botonActivo || isLoading) return;

                      () async {
                        try {
                          setState(() => isLoading = true);

                          final usuarioActualizado = usuario.copyWith(
                            nombre    : nombreCtrl.text.trim(),
                            correo    : correoCtrl.text.trim(),
                            contrasena: passwordCtrl.text.trim(),
                            telefono  : telefonoCtrl.text.trim(),
                            direccion : direccionCtrl.text.trim(),
                          );

                          await UserService().updateUser(
                            usuario.id!,
                            usuarioActualizado,
                          );

                          if (context.mounted) Navigator.pop(context);
                          onUsuarioActualizado();
                        } catch (e) {
                          if (context.mounted) Navigator.pop(context);
                          debugPrint('Error al actualizar usuario: $e');
                        } finally {
                          if (context.mounted) {
                            setState(() => isLoading = false);
                          }
                        }
                      }(); // ← se invoca de inmediato
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  ).then((_) {
    nombreCtrl.dispose();
    correoCtrl.dispose();
    passwordCtrl.dispose();
    telefonoCtrl.dispose();
    direccionCtrl.dispose();
  });
}
