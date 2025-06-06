import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarEditarUsuario(BuildContext context, User usuario) {
  final nombreCtrl = TextEditingController(text: usuario.nombre);
  final correoCtrl = TextEditingController(text: usuario.correo);
  final passwordCtrl = TextEditingController(text: usuario.contrasena);
  final telefonoCtrl = TextEditingController(text: usuario.telefono);
  final direccionCtrl = TextEditingController(text: usuario.direccion);
  final seguroSocialCtrl = TextEditingController(text: usuario.suguroSocial);
  final arlCtrl = TextEditingController(text: usuario.arl);

  String rolSeleccionado = usuario.rol;

  bool botonActivo = false;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        void validarBoton() {
          setState(() {
            botonActivo = nombreCtrl.text.isNotEmpty &&
                correoCtrl.text.isNotEmpty &&
                passwordCtrl.text.isNotEmpty;
            // Puedes agregar más validaciones si quieres
          });
        }

        // Solo agregar listeners una vez para evitar múltiples
        // Por simplicidad se puede usar un flag local, o mejor manejar en initState
        nombreCtrl.removeListener(validarBoton);
        correoCtrl.removeListener(validarBoton);
        passwordCtrl.removeListener(validarBoton);

        nombreCtrl.addListener(validarBoton);
        correoCtrl.addListener(validarBoton);
        passwordCtrl.addListener(validarBoton);

        // Llamar la validación al inicio para que el botón esté activo si ya hay datos
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
                      .map((rol) =>
                          DropdownMenuItem(value: rol, child: Text(rol)))
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
                  // Aquí la lógica para guardar cambios
                  print('Usuario editado:');
                  print('Nombre: ${nombreCtrl.text}');
                  print('Correo: ${correoCtrl.text}');
                  print('Contraseña: ${passwordCtrl.text}');
                  print('Rol: $rolSeleccionado');
                  print('Teléfono: ${telefonoCtrl.text}');
                  print('Dirección: ${direccionCtrl.text}');
                  print('Seguro Social: ${seguroSocialCtrl.text}');
                  print('ARL: ${arlCtrl.text}');
                  Navigator.of(context).pop();
                }
              : null,
        );
      },
    ),
  );
}
