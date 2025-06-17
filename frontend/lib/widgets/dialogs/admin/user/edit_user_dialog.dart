import 'package:flutter/material.dart';
import 'package:frontend/helper/formulario_usuario_helper.dart' show buildFormularioUsuario;
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
            child: buildFormularioUsuario(
              nombreCtrl: nombreCtrl,
              correoCtrl: correoCtrl,
              passwordCtrl: passwordCtrl,
              telefonoCtrl: telefonoCtrl,
              direccionCtrl: direccionCtrl,
              isPasswordVisible: passwordVisible,
              onTogglePassword: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
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
            }
          }
              : null,
        );
      },
    ),
  );
}
