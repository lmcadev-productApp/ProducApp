import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre Completo',
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
                  Text('Correo Electrónico',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  TextField(
                    controller: correoCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Ingrese el correo',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Contraseña Temporal',
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
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Ingrese el teléfono',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
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
                    final nuevoUsuario = User(
                      correo: correoCtrl.text,
                      contrasena: passwordCtrl.text,
                      nombre: nombreCtrl.text,
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
