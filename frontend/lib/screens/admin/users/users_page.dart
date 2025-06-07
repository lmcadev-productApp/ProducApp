import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/widgets/buttons/customizable_modal_options.dart';
import 'package:frontend/widgets/dialogs/admin/user/delete_user_dialog.dart';
import 'package:frontend/widgets/dialogs/admin/user/edit_user_role_dialog.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/lists/admin/user/user_list.dart';
import 'package:frontend/widgets/searches/search_input.dart';
import 'package:frontend/widgets/dialogs/admin/user/add_user_dialog.dart';
import 'package:frontend/widgets/dialogs/admin/user/edit_user_dialog.dart';

class AdminUserStateManagement extends StatefulWidget {
  @override
  _AdminUserStateManagementState createState() =>
      _AdminUserStateManagementState();
}

class _AdminUserStateManagementState extends State<AdminUserStateManagement> {
  final UserService userService = UserService();
  List<User> usuarios = []; // Aquí se guardaran los usuarios cargados
  List<User> usuariosFiltrados = [];

  @override
  void initState() {
    super.initState();
    cargarUsuarios();
  }

  void cargarUsuarios() async {
    try {
      List<User> lista = await userService.getUsers();
      setState(() {
        usuarios = lista;
        usuariosFiltrados = lista;
      });
    } catch (e) {
      // Manejo de error simple
      print('Error cargando usuarios: $e');
    }
  }

  void mostrarOpcionesUsuario(BuildContext context, dynamic user) {
    ModalOptionsCustomizable.mostrar(
      context: context,
      titulo: 'Usuario: ${user.nombre}',
      acciones: [
        AccionModal(
          icono: Icons.edit,
          titulo: 'Editar Rol',
          alPresionar: () {
            // Navegar a editar usuario
            mostrarEditarRolUsuario(context, user, () {
              cargarUsuarios();
            }); // donde 'usuario' es la instancia de Us
            print('Editar usuario: ${user.nombre}');
          },
        ),
        AccionModal(
          icono: Icons.edit,
          titulo: 'Editar',
          alPresionar: () {
            // Navegar a editar usuario
            mostrarEditarUsuario(context, user, () {
              cargarUsuarios();
            }); // donde 'usuario' es la instancia de Us
            print('Editar usuario: ${user.nombre}');
          },
        ),
        AccionModal(
          icono: Icons.delete,
          titulo: 'Eliminar',
          alPresionar: () {
            alPresionarEliminar(context, user, () {
              cargarUsuarios();
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget contenidoPantalla = Column(
      children: [
        SearchInput(hintText: 'Buscar Usuario...', espacioInferior: true),
        CustomButton(
          texto: 'Agregar Usuario',
          onPressed: () {
            mostrarAgregarUsuarioVisual(context, () {
              cargarUsuarios();
            });
            print('Botón Agregar Usuario Presionado');
          },
        ),
        Expanded(
          child: ListUser(
            users: usuarios,
            onTap: (user) {
              print('Usuario seleccionado: ${user.nombre}');
            },
            onLongPress: (user) {
              mostrarOpcionesUsuario(context, user);
            },
          ),
        ),
      ],
    );

    return BaseScreen(
      titulo: 'Gestión de Usuarios',
      contenido: contenidoPantalla,
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
