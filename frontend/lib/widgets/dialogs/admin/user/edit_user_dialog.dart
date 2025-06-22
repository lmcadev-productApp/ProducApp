import 'package:flutter/material.dart';
import 'package:frontend/helper/input_form_field.dart' show inputFormField;
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';
import 'package:frontend/helper/snackbar_helper.dart';

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

  bool isLoading   = false;
  bool passVisible = false;
  bool botonActivo = false;

  final origNombre    = usuario.nombre.trim();
  final origCorreo    = usuario.correo.trim();
  final origPass      = usuario.contrasena.trim();
  final origTelefono  = usuario.telefono.trim();
  final origDireccion = usuario.direccion.trim();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogCtx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          void _validarCampos() {
            if (!ctx.mounted) return;

            final nom  = nombreCtrl.text.trim();
            final cor  = correoCtrl.text.trim();
            final pas  = passwordCtrl.text.trim();
            final tel  = telefonoCtrl.text.trim();
            final dir  = direccionCtrl.text.trim();

            final huboCambios = nom != origNombre ||
                cor != origCorreo ||
                pas != origPass ||
                tel != origTelefono ||
                dir != origDireccion;

            final obligatoriosCompletos =
                nom.isNotEmpty && cor.isNotEmpty && pas.isNotEmpty;

            setState(() {
              botonActivo = obligatoriosCompletos && huboCambios;
            });
          }

          return WillPopScope(
            onWillPop: () async => !isLoading,
            child: DialogoGeneral(
              titulo: 'Editar usuario',
              contenido: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inputFormField(
                      label: 'Nombre',
                      hint: 'Ingrese el nombre',
                      controller: nombreCtrl,
                      onChanged: (_) => _validarCampos(),
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Correo',
                      hint: 'Ingrese el correo',
                      controller: correoCtrl,
                      tipoTeclado: TextInputType.emailAddress,
                      onChanged: (_) => _validarCampos(),
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Contraseña',
                      hint: 'Ingrese la contraseña',
                      controller: passwordCtrl,
                      isPassword: true,
                      passwordVisible: passVisible,
                      onTogglePassword: () =>
                          setState(() => passVisible = !passVisible),
                      onChanged: (_) => _validarCampos(),
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Teléfono',
                      hint: 'Ingrese el teléfono',
                      controller: telefonoCtrl,
                      tipoTeclado: TextInputType.phone,
                      onChanged: (_) => _validarCampos(),
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Dirección',
                      hint: 'Ingrese la dirección',
                      controller: direccionCtrl,
                      onChanged: (_) => _validarCampos(),
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
                    PrimaryButton(
                      text: 'Cancelar',
                      width: 135,
                      height: 48,
                      fontSize: 16,
                      backgroundColor: AppColors.azulIntermedio,
                      onPressed: () {
                        if (!isLoading) Navigator.pop(ctx);
                      },
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
                      onPressed: !botonActivo
                          ? null
                          : () async {
                        if (!ctx.mounted) return;
                        setState(() => isLoading = true);

                        final actualizado = usuario.copyWith(
                          nombre: nombreCtrl.text.trim(),
                          correo: correoCtrl.text.trim(),
                          contrasena: passwordCtrl.text.trim(),
                          telefono: telefonoCtrl.text.trim(),
                          direccion: direccionCtrl.text.trim(),
                        );

                        try {
                          await UserService()
                              .updateUser(usuario.id!, actualizado);

                          if (!context.mounted) return;
                          Navigator.pop(ctx);

                          Future.delayed(
                            const Duration(milliseconds: 50),
                                () {
                              onUsuarioActualizado();
                              showCustomSnackBar(
                                context,
                                '✅ Usuario actualizado correctamente',
                              );
                            },
                          );
                        } catch (e, stack) {
                          if (!context.mounted) return;
                          Navigator.pop(ctx);

                          Future.delayed(
                            const Duration(milliseconds: 50),
                                () => showCustomSnackBar(
                              context,
                              '❌ Error: ${e.toString()}',
                            ),
                          );

                          debugPrint('⛔ Error al actualizar usuario: $e');
                          debugPrint('🔍 Stacktrace:\n$stack');
                        }

                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
