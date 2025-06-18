import 'package:flutter/material.dart';
import 'package:frontend/helper/formulario_usuario_helper.dart'
    show buildFormularioUsuario;
import 'package:frontend/helper/input_form_field.dart' show inputFormField;
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/utils/app_text_styles.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarAgregarUsuarioVisual(
    BuildContext context, VoidCallback onUsuarioCreado) {
  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();

  bool botonActivo = false;
  bool passwordVisible = false;
  bool listenersAgregados = false;

  void validarBoton(StateSetter setState) {
    final activo = nombreCtrl.text.isNotEmpty &&
        correoCtrl.text.isNotEmpty &&
        passwordCtrl.text.isNotEmpty;
    if (activo != botonActivo) {
      setState(() {
        botonActivo = activo;
      });
    }
  }

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          if (!listenersAgregados) {
            nombreCtrl.addListener(() => validarBoton(setState));
            correoCtrl.addListener(() => validarBoton(setState));
            passwordCtrl.addListener(() => validarBoton(setState));
            listenersAgregados = true;
          }

          return DialogoGeneral(
            titulo: 'Agregar un nuevo usuario',
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
                    final nuevoUsuario = User(
                      correo: correoCtrl.text,
                      contrasena: passwordCtrl.text,
                      nombre: nombreCtrl.text,
                      rol: 'OPERARIO',
                      telefono: telefonoCtrl.text,
                      direccion: direccionCtrl.text,
                      especialidad: null,
                      suguroSocial: null,
                      arl: null,
                    );

                    try {
                      final userService = UserService();
                      final mensaje =
                          await userService.createUser(nuevoUsuario);
                      print('Respuesta backend: $mensaje');
                      Navigator.of(context).pop();
                      onUsuarioCreado();
                    } catch (e) {
                      print('Error al crear usuario: $e');
                    }
                  }
                : null,
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
