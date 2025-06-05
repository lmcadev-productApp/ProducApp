import 'package:flutter/material.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarAgregarUsuarioVisual(BuildContext context) {
  // Controllers para los TextField
  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();
  final seguroSocialCtrl = TextEditingController();
  final arlCtrl = TextEditingController();

  // Variables para Dropdowns
  String rolSeleccionado = 'Administrador';
  String especialidadSeleccionada = 'Pintura';

  // Para manejar el estado del botón Guardar
  bool botonActivo = false;

  // Un StatefulBuilder permite setState dentro del diálogo
  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        // Función para validar si se activa el botón
        void validarBoton() {
          setState(() {
            botonActivo = nombreCtrl.text.isNotEmpty &&
                correoCtrl.text.isNotEmpty &&
                passwordCtrl.text.isNotEmpty;
            // Puedes agregar más validaciones aquí si quieres
          });
        }

        // Se llama validarBoton cada vez que cambia algún campo
        nombreCtrl.addListener(validarBoton);
        correoCtrl.addListener(validarBoton);
        passwordCtrl.addListener(validarBoton);

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
                  enabled: true,
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
                  enabled: true,
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
                  enabled: true,
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
                      .map((rol) => DropdownMenuItem<String>(
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
                  decoration: InputDecoration(
                    hintText: 'Ingrese el teléfono',
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  enabled: true,
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
                  enabled: true,
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
                      .map((esp) => DropdownMenuItem<String>(
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
                  enabled: true,
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
                  enabled: true,
                ),
              ],
            ),
          ),
          textoBotonOk: 'Guardar',
          textoBotonCancelar: 'Cancelar',
          onOk: botonActivo
              ? () {
                  //Logica
                  print('Nombre: ${nombreCtrl.text}');
                  print('Correo: ${correoCtrl.text}');
                  print('Contraseña: ${passwordCtrl.text}');
                  print('Rol: $rolSeleccionado');
                  print('Teléfono: ${telefonoCtrl.text}');
                  print('Dirección: ${direccionCtrl.text}');
                  print('Especialidad: $especialidadSeleccionada');
                  print('Seguro Social: ${seguroSocialCtrl.text}');
                  print('ARL: ${arlCtrl.text}');
                  Navigator.of(context).pop(); // Cierra el diálogo
                }
              : null,
        );
      },
    ),
  );
}
