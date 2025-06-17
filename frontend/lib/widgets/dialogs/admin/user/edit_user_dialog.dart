import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarEditarUsuario(
    BuildContext context, User usuario, VoidCallback onUsuarioActualizado) {
  final nombreCtrl = TextEditingController(text: usuario.nombre);
  final correoCtrl = TextEditingController(text: usuario.correo);
  final passwordCtrl = TextEditingController(text: usuario.contrasena);
  final telefonoCtrl = TextEditingController(text: usuario.telefono);
  final direccionCtrl = TextEditingController(text: usuario.direccion);

  bool botonActivo = false;
  bool passwordVisible = false;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        void validarBoton() {
          setState(() {
            botonActivo = nombreCtrl.text.isNotEmpty &&
                correoCtrl.text.isNotEmpty &&
                passwordCtrl.text.isNotEmpty;
          });
        }

        nombreCtrl.removeListener(validarBoton);
        correoCtrl.removeListener(validarBoton);
        passwordCtrl.removeListener(validarBoton);

        nombreCtrl.addListener(validarBoton);
        correoCtrl.addListener(validarBoton);
        passwordCtrl.addListener(validarBoton);

        validarBoton();

        return DialogoGeneral(
          titulo: 'Editar usuario',
          contenido: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                TextField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(
                    hintText: 'Ingrese el nombre',
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
                SizedBox(height: 15),
                Text('Correo',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                TextField(
                  controller: correoCtrl,
                  decoration: InputDecoration(
                    hintText: 'Ingrese el correo',
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15),
                Text('Contraseña',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                TextField(
                  controller: passwordCtrl,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Ingrese la contraseña',
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text('Teléfono',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                TextField(
                  controller: telefonoCtrl,
                  decoration: InputDecoration(
                    hintText: 'Ingrese el teléfono',
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 15),
                Text('Dirección',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                TextField(
                  controller: direccionCtrl,
                  decoration: InputDecoration(
                    hintText: 'Ingrese la dirección',
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
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
              nombre: nombreCtrl.text,
              correo: correoCtrl.text,
              contrasena: passwordCtrl.text,
              rol: usuario.rol,
              telefono: telefonoCtrl.text,
              direccion: direccionCtrl.text,
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