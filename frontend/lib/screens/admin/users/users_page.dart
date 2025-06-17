import 'package:flutter/material.dart';
import 'package:frontend/models/stages/stage.dart';
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
  List<User> usuarios = []; // Lista original
  List<User> usuariosFiltrados = []; // Lista filtrada para mostrar
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cargarUsuarios();

    // Listener para filtrar cuando cambie el texto en el SearchInput
    searchController.addListener(() {
      filtrarUsuarios(searchController.text);
    });
  }

  void cargarUsuarios({Stage? stage}) async {
    try {
      List<User> lista = await userService.getUsers();
      setState(() {
        usuarios = lista;
        usuariosFiltrados = lista;
      });
    } catch (e) {
      print('Error cargando usuarios: $e');
    }
  }

  void filtrarUsuarios(String query) {
    if (query.isEmpty) {
      setState(() {
        usuariosFiltrados = usuarios;
      });
    } else {
      final filtrados = usuarios.where((user) {
        return user.correo.toLowerCase().contains(query.toLowerCase()) ||
            user.contrasena.toLowerCase().contains(query.toLowerCase()) ||
            (user.rol != null &&
                user.rol!.toLowerCase().contains(query.toLowerCase())) ||
            user.nombre.toLowerCase().contains(query.toLowerCase()) ||
            user.telefono.toLowerCase().contains(query.toLowerCase()) ||
            user.direccion.toLowerCase().contains(query.toLowerCase()) ||
            (user.especialidad != null &&
                user.especialidad!
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase())) ||
            (user.suguroSocial != null &&
                user.suguroSocial!
                    .toLowerCase()
                    .contains(query.toLowerCase())) ||
            (user.arl != null &&
                user.arl!.toLowerCase().contains(query.toLowerCase()));
      }).toList();
      setState(() {
        usuariosFiltrados = filtrados;
      });
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
            mostrarEditarRolUsuario(context, user, () {
              cargarUsuarios();
            });
            print('Editar usuario: ${user.nombre}');
          },
        ),
        AccionModal(
          icono: Icons.edit,
          titulo: 'Editar',
          alPresionar: () {
            mostrarEditarUsuario(context, user, () {
              cargarUsuarios();
            });
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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen<User>(
      titulo: 'Gestión de Usuarios',

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mostrarAgregarUsuarioVisual(context, () {
            cargarUsuarios();
          });
        },
        child: const Icon(Icons.add),
      ),
      contenidoPersonalizado: Column(
        children: [
          SearchInput(
            hintText: 'Buscar Usuario...',
            espacioInferior: true,
            controller: searchController,
          ),
          Expanded(
            child: ListUser(
              users: usuariosFiltrados,
              onEdit: (usuario) {
                mostrarEditarUsuario(context, usuario, () {
                  cargarUsuarios();
                });
              },
            ),
          ),
        ],
      ),
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
