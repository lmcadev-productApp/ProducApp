import 'package:flutter/material.dart';
import 'package:frontend/models/admin/user_test.dart';
import 'package:frontend/services/data_service_test.dart';
import 'package:frontend/widgets/admin/user_card.dart';
import 'package:frontend/widgets/Section/section_header.dart';
import 'package:frontend/widgets/admin/add_user_dialog.dart';
import 'package:frontend/widgets/admin/edit_user_dialog.dart';

class UserStateManagement extends StatefulWidget {
  @override
  _UserStateManagementState createState() => _UserStateManagementState();
}

class _UserStateManagementState extends State<UserStateManagement> {
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
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              usuario.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text('Editar'),
              onTap: () {
                Navigator.pop(context);
                _editarUsuario(usuario);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Eliminar'),
              onTap: () {
                Navigator.pop(context);
                _eliminarUsuario(usuario);
              },
            ),
          ],
        ),
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
    // Aquí defines el contenido específico de esta pantalla
    Widget contenidoPantalla = Column(
      children: [
        // Campo de búsqueda
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: const Color.fromARGB(255, 109, 109, 109),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _controladorBusqueda,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              hintText: 'Buscar usuario...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Botón agregar
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _agregarUsuario,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Agregar Usuario',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Lista de usuarios
        Expanded(
          child: usuariosFiltrados.isEmpty
              ? Center(
                  child: Text(
                    'No se encontraron usuarios',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                )
              : ListView.builder(
                  itemCount: usuariosFiltrados.length,
                  itemBuilder: (_, i) {
                    final usuario = usuariosFiltrados[i];
                    return UserCard(
                      user: usuario,
                      onTap: () => print("👤 Usuario: ${usuario.name}"),
                      onLongPress: () => _mostrarOpcionesUsuario(usuario),
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
