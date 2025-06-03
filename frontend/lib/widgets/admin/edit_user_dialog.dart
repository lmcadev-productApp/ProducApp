import 'package:flutter/material.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';
import 'package:frontend/models/admin/user_test.dart';

void mostrarEditarUsuario(
  BuildContext context,
  User usuario,
  Function(User) onUserUpdated,
) {
  final nombreController = TextEditingController(text: usuario.name);
  final emailController = TextEditingController(text: usuario.email);
  final passwordController = TextEditingController();
  final celularController = TextEditingController(text: usuario.celular ?? '');
  String? rolSeleccionado = usuario.role.isNotEmpty ? usuario.role : null;
  String? especialidadSeleccionada = usuario.especialidad ?? null;

  showDialog(
    context: context,
    builder: (context) => DialogoGeneral(
      titulo: 'Editar usuario',
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
                  rolSeleccionado = nuevoRol;
                  if (nuevoRol != 'Operador') {
                    celularController.clear();
                    especialidadSeleccionada = null;
                  }
                });
              },
              hint: Text('Seleccione un rol'),
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
                    especialidadSeleccionada = nuevaEspecialidad;
                  });
                },
                hint: Text('Seleccione una especialidad'),
              ),
              SizedBox(height: 15),
            ],

            // Contraseña (opcional)
            Text('Contraseña (dejar vacío para no cambiar)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Ingrese la nueva contraseña',
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
        if (rolSeleccionado == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Seleccione un rol')),
          );
          return;
        }
        if (rolSeleccionado == 'Operador' && celularController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ingrese el número de celular')),
          );
          return;
        }

        // Construir el usuario actualizado, manteniendo la contraseña si está vacía
        User usuarioActualizado = User(
          name: nombreController.text,
          email: emailController.text,
          role: rolSeleccionado!,
          password: passwordController.text.isEmpty
              ? usuario.password
              : passwordController.text,
          celular:
              rolSeleccionado == 'Operador' ? celularController.text : null,
          especialidad:
              rolSeleccionado == 'Operador' ? especialidadSeleccionada : null,
        );

        Navigator.pop(context);
        onUserUpdated(usuarioActualizado);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario actualizado exitosamente')),
        );
      },
    ),
  );
}
