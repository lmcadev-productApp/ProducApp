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
          espacioInferior: true,
        ),

        // Lista de usuarios
        Expanded(
          child: ListUser(
            users: usuarios,
            onTap: (user) {
              print('Usuario seleccionado: ${user.nombre}');
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
