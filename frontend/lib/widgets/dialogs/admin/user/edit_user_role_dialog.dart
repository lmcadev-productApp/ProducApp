import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarEditarRolUsuario(
    BuildContext context, User usuario, VoidCallback onUsuarioActualizado) {
  final List<String> roles = ['ADMINISTRADOR', 'SUPERVISOR', 'OPERARIO', 'CLIENTE'];
  String rolSeleccionado = usuario.rol ?? roles.first;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return DialogoGeneral(
            titulo: 'Editar rol usuario',
            contenido: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Rol',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: rolSeleccionado,
                  isExpanded: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  items: roles
                      .map((rol) => DropdownMenuItem(
                    value: rol,
                    child: Text(rol),
                  ))
                      .toList(),
                  onChanged: (nuevoRol) {
                    if (nuevoRol != null) {
                      setState(() {
                        rolSeleccionado = nuevoRol;
                      });
                    }
                  },
                ),
              ],
            ),
            textoBotonOk: 'Guardar',
            textoBotonCancelar: 'Cancelar',
            onOk: () async {
              final usuarioActualizado = usuario.copyWith(
                rol: rolSeleccionado,
              );

              try {
                final userService = UserService();
                final mensaje = await userService.updateUser(usuario.id!, usuarioActualizado);
                print('Respuesta backend: $mensaje');
                Navigator.of(context).pop();
                onUsuarioActualizado();
              } catch (e) {
                print('Error al actualizar usuario: $e');
              }
            },
          );
        },
      );
    },
  );
}
