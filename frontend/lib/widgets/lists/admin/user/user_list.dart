import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/utils/role_color.dart';

// Widget que muestra una lista de usuarios
class ListUser extends StatelessWidget {
  final List<User> users; // Lista de usuarios
  final Function(User)? onTap; // Qué hacer cuando tocan un usuario
  final Function(User)?
      onLongPress; // Qué hacer cuando mantienen presionado un usuario

  const ListUser({
    Key? key,
    required this.users,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Crear una lista con separadores
    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: 8), // Espacio entre tarjetas
      itemBuilder: (context, index) {
        User user = users[index];

        // Crear tarjeta para cada usuario
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap != null ? () => onTap!(user) : null,
            onLongPress: onLongPress != null ? () => onLongPress!(user) : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. NOMBRE Y ROL DEL USUARIO
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.nombre,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: getRoleColor(user.rol),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user.rol,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // 2. INFORMACIÓN DE CONTACTO
                _buildContactRow(user.correo),
                _buildContactRow(user.telefono),
                _buildContactRow(user.direccion),

                SizedBox(height: 10),

                // 3. ESPECIALIDAD
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Especialidad: ${user.especialidad.nombre}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (user.especialidad.descripcion.isNotEmpty)
                        Text(
                          user.especialidad.descripcion,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // 4. EPS Y ARL
                Row(
                  children: [
                    Expanded(
                        child: Text('EPS: ${user.suguroSocial}',
                            style: TextStyle(fontSize: 14))),
                    Expanded(
                        child: Text('ARL: ${user.arl}',
                            style: TextStyle(fontSize: 14))),
                  ],
                ),

                SizedBox(height: 6),

                // 5. ID DEL USUARIO
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ID: ${user.id}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget simple para mostrar información de contacto
  Widget _buildContactRow(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
      ),
    );
  }
}
