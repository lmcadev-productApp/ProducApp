import 'package:flutter/material.dart';
import 'package:frontend/helper/confirm_delete_helper.dart'
    show confirmarEliminacion;
import 'package:frontend/helper/snackbar_helper.dart' show showCustomSnackBar;
import 'package:frontend/models/stages/stage.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/buttons/customizable_modal_options.dart';
import 'package:frontend/widgets/dialogs/admin/user/delete_user_dialog.dart';
import 'package:frontend/widgets/dialogs/admin/user/edit_user_role_dialog.dart';
import 'package:frontend/widgets/section/section_header.dart';
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
        heroTag: 'fab_usuarios_${DateTime.now().millisecondsSinceEpoch}',
        onPressed: () {
          mostrarAgregarUsuarioVisual(context, cargarUsuarios);
        },
        child: const Icon(Icons.add),
      ),
      contenidoPersonalizado: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchInput(
              hintText: 'Buscar Usuario...',
              espacioInferior: true,
              controller: searchController,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListUser(
              users: usuariosFiltrados,
              onEditRole: (usuario) {
                mostrarEditarRolUsuario(context, usuario, () {
                  cargarUsuarios();
                });
              },
              onEdit: (usuario) {
                mostrarEditarUsuario(context, usuario, () {
                  cargarUsuarios();
                });
              },
              onDelete: (user) {
                confirmarEliminacion(
                  context: context,
                  titulo: 'Eliminar Usuario',
                  mensaje:
                      '¿Estás segura de eliminar al usuario "${user.nombre}"?',
                  mensajeExito: 'Usuario eliminado correctamente 🗑️',
                  mensajeError: 'Error al eliminar el usuario ❌',
                  onDelete: () async {
                    await UserService().deleteUser(user.id!);
                    cargarUsuarios(); // Refresca la lista
                  },
                );
              },
            ),
          ),
        ],
      ),
      colorHeader: AppColors.azulIntermedio,
    );
  }
}
