import 'package:flutter/material.dart';
import 'package:frontend/models/admin/user_test.dart';
import 'package:frontend/services/data_service_test.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/buttons/custom-button.dart';
import 'package:frontend/widgets/lists/admin/user-list.dart';
import 'package:frontend/widgets/lists/general_options_list.dart';
import 'package:frontend/widgets/searches/search_input.dart';
import 'package:frontend/widgets/admin/add_user_dialog.dart';
import 'package:frontend/widgets/admin/edit_user_dialog.dart';

class AdminUserStateManagement extends StatefulWidget {
  @override
  _AdminUserStateManagementState createState() =>
      _AdminUserStateManagementState();
}

class _AdminUserStateManagementState extends State<AdminUserStateManagement> {
  final TextEditingController _controladorBusqueda = TextEditingController();

  List<User> usuarios = DataService.users;
  List<User> usuariosFiltrados = [];

  @override
  void initState() {
    super.initState();
    usuariosFiltrados = usuarios;
    _controladorBusqueda.addListener(_filtrarUsuarios);
  }

  void _filtrarUsuarios() {
    final consulta = _controladorBusqueda.text.toLowerCase();
    setState(() {
      usuariosFiltrados = usuarios.where((usuario) {
        return usuario.name.toLowerCase().contains(consulta) ||
            usuario.email.toLowerCase().contains(consulta) ||
            usuario.role.toLowerCase().contains(consulta) ||
            (usuario.celular != null &&
                usuario.celular!.toLowerCase().contains(consulta)) ||
            (usuario.especialidad != null &&
                usuario.especialidad!.toLowerCase().contains(consulta));
      }).toList();
    });
  }

  void _agregarUsuario() {
    mostrarAgregarUsuario(context, (User nuevoUsuario) {
      setState(() {
        usuarios.add(nuevoUsuario);
        usuariosFiltrados = usuarios;
      });
    });
  }

  void _editarUsuario(User usuario) {
    mostrarEditarUsuario(context, usuario, (User usuarioEditado) {
      setState(() {
        final indice = usuarios.indexWhere((u) => u.email == usuario.email);
        if (indice != -1) {
          usuarios[indice] = usuarioEditado;
        }
        usuariosFiltrados = usuarios;
      });
    });
  }

  void _eliminarUsuario(User usuario) {
    setState(() {
      usuarios.remove(usuario);
      usuariosFiltrados.remove(usuario);
    });
    print("Usuario eliminado: ${usuario.name}");
  }

  void _mostrarOpcionesUsuario(User usuario) {
    showModalBottomSheet(
      context: context,
      builder: (_) => GeneralOptionsSheet(
        titulo: usuario.name,
        opciones: [
          OpcionItem(
            icono: Icons.edit,
            colorIcono: Colors.blue,
            texto: 'Editar',
            onTap: () => _editarUsuario(usuario),
          ),
          OpcionItem(
            icono: Icons.delete,
            colorIcono: Colors.red,
            texto: 'Eliminar',
            onTap: () => _eliminarUsuario(usuario),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controladorBusqueda.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Contenido de la pantalla
    Widget contenidoPantalla = Column(
      children: [
        // Campo de búsqueda
        SearchInput(
            controller: _controladorBusqueda,
            hintText: 'Buscar Usuario...',
            espacioInferior: true),

        // Botón agregar
        CustomButton(
          texto: 'Agregar Usuario',
          espacioInferior: true,
          onPressed: _agregarUsuario,
        ),

        // Lista de usuarios
        ListUser(
          usuarios: usuariosFiltrados,
          onUsuarioTap: (usuario) {
            print("👤 Usuario: ${usuario.name}");
          },
          onUsuarioLongPress: _mostrarOpcionesUsuario,
        )
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
