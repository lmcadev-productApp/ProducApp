import 'package:flutter/material.dart';
import 'package:frontend/widgets/admin/user_card.dart';
import 'package:frontend/models/admin/user_test.dart';

class ListUser extends StatelessWidget {
  final List<User> usuarios;
  final void Function(User) onUsuarioLongPress;
  final void Function(User)? onUsuarioTap;

  const ListUser({
    super.key,
    required this.usuarios,
    required this.onUsuarioLongPress,
    this.onUsuarioTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: usuarios.isEmpty
          ? Center(
              child: Text(
                'No se encontraron usuarios',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (_, i) {
                final usuario = usuarios[i];
                return UserCard(
                  user: usuario,
                  onTap: () => onUsuarioTap?.call(usuario),
                  onLongPress: () => onUsuarioLongPress(usuario),
                );
              },
            ),
    );
  }
}
