import 'package:flutter/material.dart';
import 'package:frontend/widgets/dialogs/dialog_general.dart';

void mostrarEditarUsuario(BuildContext context) {
  // Solo para mostrar la UI, sin lógica ni controladores activos
  showDialog(
    context: context,
    builder: (context) => DialogoGeneral(
      titulo: 'Editar usuario',
      contenido: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese el nombre',
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              enabled: false,
            ),
            SizedBox(height: 15),
            Text('Correo',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese el correo',
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              enabled: false,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15),
            Text('Contraseña',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
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
              enabled: false,
            ),
            SizedBox(height: 15),
            Text('Rol',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              items: ['Administrador', 'Supervisor', 'Operador']
                  .map((rol) => DropdownMenuItem(value: rol, child: Text(rol)))
                  .toList(),
              onChanged: null,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            SizedBox(height: 15),
            Text('Teléfono',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese el teléfono',
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              enabled: false,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 15),
            Text('Dirección',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese la dirección',
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              enabled: false,
            ),
            SizedBox(height: 15),
            Text('Especialidad',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              items: ['Pintura', 'Carpintería', 'Acabados']
                  .map((esp) => DropdownMenuItem(value: esp, child: Text(esp)))
                  .toList(),
              onChanged: null,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            SizedBox(height: 15),
            Text('Seguro Social',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese el seguro social',
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              enabled: false,
            ),
            SizedBox(height: 15),
            Text('ARL',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Ingrese la ARL',
                filled: true,
                fillColor: Colors.grey[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              enabled: false,
            ),
          ],
        ),
      ),
      textoBotonOk: 'Guardar',
      textoBotonCancelar: 'Cancelar',
      onOk: () {
        Navigator.of(context).pop(); // Cierra el diálogo
      },
    ),
  );
}
