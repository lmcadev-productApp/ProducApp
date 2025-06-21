import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/utils/app_text_styles.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarEditarRolUsuario(
    BuildContext context,
    User usuario,
    VoidCallback onUsuarioActualizado,
    ) {
  final List<String> roles = [
    'ADMINISTRADOR',
    'SUPERVISOR',
    'OPERARIO',
    'CLIENTE',
  ];

  String rolSeleccionado = usuario.rol ?? roles.first;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          bool isLoading   = false;
          bool rolCambiado = rolSeleccionado != (usuario.rol ?? roles.first);

          return DialogoGeneral(
            titulo: 'Editar rol usuario',
            contenido: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rol', style: AppTextStyles.subtitulo),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: rolSeleccionado,
                  isExpanded: true,
                  dropdownColor: AppColors.azulClaroFondo,
                  menuMaxHeight: 250,
                  itemHeight: 48,
                  borderRadius: BorderRadius.circular(8),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.azulIntermedio, width: 1.4),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  ),
                  // Items normales
                  items: roles
                      .map(
                        (rol) => DropdownMenuItem(
                      value: rol,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            color: rol == rolSeleccionado
                                ? AppColors.azulIntermedio.withOpacity(.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            rol,
                            style: TextStyle(
                              fontWeight: rol == rolSeleccionado
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      .toList(),
                  selectedItemBuilder: (ctx) => roles
                      .map(
                        (rol) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        rol,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                      .toList(),

                  onChanged: (nuevoRol) {
                    if (nuevoRol == null) return;
                    setState(() {
                      rolSeleccionado = nuevoRol;
                      rolCambiado =
                          rolSeleccionado != (usuario.rol ?? roles.first);
                    });
                  },
                ),
              ],
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
                    isEnabled: rolCambiado,
                    backgroundColor: rolCambiado
                        ? AppColors.azulIntermedio
                        : AppColors.grisTextoSecundario,
                    onPressed: () {
                      () async {
                        try {
                          setState(() => isLoading = true);

                          final usuarioActualizado =
                          usuario.copyWith(rol: rolSeleccionado);

                          await UserService().updateUser(
                              usuario.id!, usuarioActualizado);

                          Navigator.of(context).pop();
                          onUsuarioActualizado();
                        } catch (e) {
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                          print('Error al actualizar usuario: $e');
                        } finally {
                          if (context.mounted) {
                            setState(() => isLoading = false);
                          }
                        }
                      }(); //  ← se invoca inmediatamente
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
