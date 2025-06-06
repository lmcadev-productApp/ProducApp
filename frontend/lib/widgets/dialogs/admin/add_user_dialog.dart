import 'package:flutter/material.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarAgregarUsuarioVisual(BuildContext context) {
  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();
  final seguroSocialCtrl = TextEditingController();
  final arlCtrl = TextEditingController();

  String rolSeleccionado = 'Administrador';
  String especialidadSeleccionada = 'Pintura';

  bool botonActivo = false;

  // Esta función actualizará el estado del botón
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

  // Variable para evitar agregar listeners múltiples veces
  bool listenersAgregados = false;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // Agregar listeners solo la primera vez
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
                  Text('Contraseña',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  TextField(
                    controller: passwordCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Ingrese la contraseña',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 15),
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
                    items: ['Administrador', 'Supervisor', 'Operador']
                        .map((rol) => DropdownMenuItem(
                              value: rol,
                              child: Text(rol),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        rolSeleccionado = val!;
                      });
                    },
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
                  SizedBox(height: 15),
                  Text('Especialidad',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: especialidadSeleccionada,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    items: ['Pintura', 'Carpintería', 'Acabados']
                        .map((esp) => DropdownMenuItem(
                              value: esp,
                              child: Text(esp),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        especialidadSeleccionada = val!;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  Text('Seguro Social',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  TextField(
                    controller: seguroSocialCtrl,
                    decoration: InputDecoration(
                      hintText: 'Ingrese el seguro social',
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('ARL',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  TextField(
                    controller: arlCtrl,
                    decoration: InputDecoration(
                      hintText: 'Ingrese la ARL',
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
                ? () {
                    print('Nombre: ${nombreCtrl.text}');
                    print('Correo: ${correoCtrl.text}');
                    print('Contraseña: ${passwordCtrl.text}');
                    print('Rol: $rolSeleccionado');
                    print('Teléfono: ${telefonoCtrl.text}');
                    print('Dirección: ${direccionCtrl.text}');
                    print('Especialidad: $especialidadSeleccionada');
                    print('Seguro Social: ${seguroSocialCtrl.text}');
                    print('ARL: ${arlCtrl.text}');
                    Navigator.of(context).pop();
                  }
                : null,
          );
        },
      );
    },
  ).then((_) {
    // Limpiar controladores al cerrar diálogo
    nombreCtrl.dispose();
    correoCtrl.dispose();
    passwordCtrl.dispose();
    telefonoCtrl.dispose();
    direccionCtrl.dispose();
    seguroSocialCtrl.dispose();
    arlCtrl.dispose();
  });
}
