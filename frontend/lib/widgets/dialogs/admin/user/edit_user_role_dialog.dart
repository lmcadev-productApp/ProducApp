import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarEditarRolUsuario(
    BuildContext context, User usuario, VoidCallback onUsuarioActualizado) {
  final roles = ['ADMINISTRADOR', 'SUPERVISOR', 'OPERARIO', 'CLIENTE'];
  String rolSeleccionado = usuario.rol ?? roles.first;

  bool botonActivo = true;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return DialogoGeneral(
          titulo: 'Editar rol usuario',
          contenido: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rol',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: rolSeleccionado,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  items: roles
                      .map((rol) =>
                          DropdownMenuItem(value: rol, child: Text(rol)))
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
          ),
          textoBotonOk: 'Guardar',
          textoBotonCancelar: 'Cancelar',
          onOk: botonActivo
              ? () async {
                  final usuarioActualizado = User(
                    id: usuario.id,
                    nombre: usuario.nombre,
                    correo: usuario.correo,
                    contrasena: usuario.contrasena,
                    rol: rolSeleccionado,
                    telefono: usuario.telefono,
                    direccion: usuario.direccion,
                    especialidad: usuario.especialidad,
                    suguroSocial: usuario.suguroSocial,
                    arl: usuario.arl,
                  );

                  try {
                    final userService = UserService();
                    final mensaje = await userService.updateUser(
                        usuario.id!, usuarioActualizado);
                    print('Respuesta backend: $mensaje');
                    Navigator.of(context).pop();
                    onUsuarioActualizado();
                  } catch (e) {
                    print('Error al actualizar usuario: $e');
                    print('Rol usuario original: ${usuario.rol}');
                  }
                }
              : null,
        );
      },
    ),
  );
}
