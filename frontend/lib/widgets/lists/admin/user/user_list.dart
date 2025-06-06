import 'package:flutter/material.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/utils/role_color.dart';

class ListUser extends StatelessWidget {
  final List<User> users;
  final Function(User)? onTap;
  final Function(User)? onLongPress;

  const ListUser({
    Key? key,
    required this.users,
    required this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: users.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final user = users[index];
        return _buildUserCard(user);
      },
    );
  }

  // Construye la tarjeta de cada usuario
  Widget _buildUserCard(User user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap != null ? () => onTap!(user) : null,
        onLongPress: onLongPress != null ? () => onLongPress!(user) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNameAndRole(user),
            const SizedBox(height: 12),
            _buildContactInfo(user),
            const SizedBox(height: 10),
            _buildSpecialtySection(user),
            const SizedBox(height: 10),
            _buildInsuranceRow(user),
            const SizedBox(height: 6),
            _buildUserId(user),
          ],
        ),
      ),
    );
  }

  // Nombre del usuario y su rol
  Widget _buildNameAndRole(User user) {
    return Row(
      children: [
        Expanded(
          child: Text(
            user.nombre,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: getRoleColor(user.rol),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            user.rol,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  // Información de contacto (correo, teléfono, dirección)
  Widget _buildContactInfo(User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactText(user.correo),
        _buildContactText(user.telefono),
        _buildContactText(user.direccion),
      ],
    );
  }

  // Cada línea de contacto
  Widget _buildContactText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
      ),
    );
  }

  // Sección de especialidad con fondo gris
  Widget _buildSpecialtySection(User user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Especialidad: ${user.especialidad.nombre}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (user.especialidad.descripcion.isNotEmpty)
            Text(
              user.especialidad.descripcion,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
        ],
      ),
    );
  }

  // Fila con EPS y ARL
  Widget _buildInsuranceRow(User user) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'EPS: ${user.suguroSocial}',
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            'ARL: ${user.arl}',
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  // ID del usuario alineado a la derecha
  Widget _buildUserId(User user) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        'ID: ${user.id}',
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
