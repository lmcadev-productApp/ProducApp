import 'package:flutter/material.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';
import 'package:frontend/models/admin/user_test.dart';

void mostrarAgregarUsuario(BuildContext context, Function(User) onUserCreated) {
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final celularController = TextEditingController();
  String rolSeleccionado = 'Administrador'; // Valor por defecto
  String especialidadSeleccionada = 'Pintura'; // Valor por defecto

  showDialog(
    context: context,
    builder: (context) => DialogoGeneral(
      titulo: 'Agregar un nuevo usuario',
      contenido: StatefulBuilder(
        builder: (context, setState) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre completo
            Text('Nombre completo',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                hintText: 'Ingrese el nombre completo',
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            SizedBox(height: 15),

            // Correo electrónico
            Text('Correo electrónico',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Ingrese el correo electrónico',
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            SizedBox(height: 15),

            // Rol
            Text('Rol',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: rolSeleccionado,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              items:
                  ['Administrador', 'Supervisor', 'Operador'].map((String rol) {
                return DropdownMenuItem<String>(
                  value: rol,
                  child: Text(rol),
                );
              }).toList(),
              onChanged: (String? nuevoRol) {
                setState(() {
                  rolSeleccionado = nuevoRol!;
                });
              },
            ),
            SizedBox(height: 15),

            // Campos extra para Operador
            if (rolSeleccionado == 'Operador') ...[
              // Celular
              Text('Celular',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              TextField(
                controller: celularController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Ingrese el número de celular',
                  filled: true,
                  fillColor: Colors.grey[50],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              SizedBox(height: 15),

              // Especialidad
              Text('Especialidad',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
                items:
                    ['Pintura', 'Plástico', 'Metal'].map((String especialidad) {
                  return DropdownMenuItem<String>(
                    value: especialidad,
                    child: Text(especialidad),
                  );
                }).toList(),
                onChanged: (String? nuevaEspecialidad) {
                  setState(() {
                    especialidadSeleccionada = nuevaEspecialidad!;
                  });
                },
              ),
              SizedBox(height: 15),
            ],

            // Contraseña
            Text('Contraseña',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Ingrese la contraseña',
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
          ],
        ),
      ),
      textoBotonOk: 'Guardar',
      textoBotonCancelar: 'Cancelar',
      onOk: () {
        // Validar campos basicos
        if (nombreController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ingrese el nombre completo')),
          );
          return;
        }
        if (emailController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ingrese el correo electrónico')),
          );
          return;
        }
        if (passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ingrese la contraseña')),
          );
          return;
        }

        // Validar campos de operador
        if (rolSeleccionado == 'Operador' && celularController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ingrese el número de celular')),
          );
          return;
        }

        // Crear el objeto usuario
        User nuevoUsuario = User(
          name: nombreController.text,
          email: emailController.text,
          role: rolSeleccionado,
          password: passwordController.text,
          celular:
              rolSeleccionado == 'Operador' ? celularController.text : null,
          especialidad:
              rolSeleccionado == 'Operador' ? especialidadSeleccionada : null,
        );

        print('Nuevo usuario creado: ${nuevoUsuario.toJson()}');
        Navigator.pop(context);

        // Llamar el callback para avisar que se creo un usuario
        onUserCreated(nuevoUsuario);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario creado exitosamente')),
        );
      },
    ),
  );
}
