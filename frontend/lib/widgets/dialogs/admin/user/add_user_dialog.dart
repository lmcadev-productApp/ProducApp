import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/helper/input_form_field.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarAgregarUsuarioVisual(
  BuildContext context,
  VoidCallback onUsuarioCreado,
) {
  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final telCtrl = TextEditingController();
  final dirCtrl = TextEditingController();

  bool isLoading = false;
  bool passVisible = false;
  bool botonActivo = false;

  void validarCampos() {
    botonActivo = nombreCtrl.text.trim().isNotEmpty &&
        correoCtrl.text.trim().isNotEmpty &&
        passCtrl.text.trim().isNotEmpty;
  }

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return WillPopScope(
            onWillPop: () async => !isLoading,
            child: DialogoGeneral(
              titulo: 'Nuevo usuario',
              contenido: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inputFormField(
                      label: 'Nombre',
                      hint: 'Ingrese el nombre',
                      controller: nombreCtrl,
                      onChanged: (_) => setState(() {
                        validarCampos();
                      }),
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Correo',
                      hint: 'Ingrese el correo',
                      controller: correoCtrl,
                      tipoTeclado: TextInputType.emailAddress,
                      onChanged: (_) => setState(() {
                        validarCampos();
                      }),
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Contraseña',
                      hint: 'Ingrese la contraseña',
                      controller: passCtrl,
                      isPassword: true,
                      passwordVisible: passVisible,
                      onTogglePassword: () =>
                          setState(() => passVisible = !passVisible),
                      onChanged: (_) => setState(() {
                        validarCampos();
                      }),
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Teléfono',
                      hint: 'Ingrese el teléfono',
                      controller: telCtrl,
                      tipoTeclado: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    inputFormField(
                      label: 'Dirección',
                      hint: 'Ingrese la dirección',
                      controller: dirCtrl,
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

                                  final nuevoUsuario = User(
                                    nombre: nombreCtrl.text.trim(),
                                    correo: correoCtrl.text.trim(),
                                    contrasena: passCtrl.text.trim(),
                                    rol: 'OPERARIO',
                                    telefono: telCtrl.text.trim(),
                                    direccion: dirCtrl.text.trim(),
                                    especialidad: null,
                                    suguroSocial: null,
                                    arl: null,
                                  );

                                  await UserService().createUser(nuevoUsuario);

                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    onUsuarioCreado();
                                  }
                                } catch (e) {
                                  debugPrint('Error al crear usuario: $e');
                                  if (context.mounted) Navigator.pop(context);
                                } finally {
                                  if (context.mounted) {
                                    setState(() => isLoading = false);
                                  }
                                }
                              }();
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
  ).then((_) {
    // Espera a que termine de cerrar animaciones antes de hacer dispose
    Future.delayed(const Duration(milliseconds: 300), () {
      nombreCtrl.dispose();
      correoCtrl.dispose();
      passCtrl.dispose();
      telCtrl.dispose();
      dirCtrl.dispose();
    });
  });
}
