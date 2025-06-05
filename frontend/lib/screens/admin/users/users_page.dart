import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/data_service_test.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/lists/admin/user/user_list.dart';
import 'package:frontend/widgets/searches/search_input.dart';
import 'package:frontend/widgets/dialogs/admin/add_user_dialog.dart';
import 'package:frontend/widgets/dialogs/admin/edit_user_dialog.dart';

class AdminUserStateManagement extends StatefulWidget {
  @override
  _AdminUserStateManagementState createState() =>
      _AdminUserStateManagementState();
}

class _AdminUserStateManagementState extends State<AdminUserStateManagement> {
  List<User> usuarios = UserService.users;
  List<User> usuariosFiltrados = [];

  @override
  Widget build(BuildContext context) {
    // Contenido de la pantalla
    Widget contenidoPantalla = Column(
      children: [
        // Campo de búsqueda
        SearchInput(hintText: 'Buscar Usuario...', espacioInferior: true),

        // Botón agregar
        CustomButton(
          texto: 'Agregar Usuario',
          onPressed: () {
            //Lógica aquí
            mostrarAgregarUsuarioVisual(context);
            print('Botón Agregar Usuario Presionado');
          },
          espacioInferior: true,
        ),

        // Lista de usuarios
        Expanded(
          child: ListUser(
            users: usuarios,
            onTap: (user) {
              //Logica al tocar
              print('Usuario seleccionado: ${user.nombre}');
            },
            onLongPress: (user) {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                backgroundColor: const Color(0xFF4A90E2),
                builder: (BuildContext context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Usuario seleccionado: ${user.nombre}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Divider(color: Colors.white70),
                      ListTile(
                        leading: Icon(Icons.edit, color: Colors.white),
                        title: Text('Editar',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          //Logica
                          Navigator.pop(context);
                          mostrarEditarUsuario(context);
                          print('Editar usuario: ${user.nombre}');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.delete, color: Colors.white),
                        title: Text('Eliminar',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          //Logica
                          Navigator.pop(context);
                          print('Eliminar usuario: ${user.nombre}');
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );

    // Usar el widget reutilizable
    return BaseScreen(
      titulo: 'Gestión de Usuarios',
      contenido: contenidoPantalla,
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
