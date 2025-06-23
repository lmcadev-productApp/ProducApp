import 'package:flutter/material.dart';
import 'package:frontend/helper/snackbar_helper.dart';
import 'package:frontend/models/users/user.dart';
import 'package:frontend/services/users/user_service.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/utils/app_text_styles.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/widgets/dialogs/admin/user/edit_user_dialog.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserService userService = UserService();
  late Future<User?> _usuario;

  @override
  void initState() {
    super.initState();
    _usuario = userService.getUsuarioActual();
  }

  void _recargarUsuario() {
    setState(() {
      _usuario = userService.getUsuarioActual();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _usuario,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
              body: Center(child: Text('No se encontró el usuario.')));
        }

        final user = snapshot.data!;

        return BaseScreen(
          titulo: 'Perfil de Usuario',
          colorHeader: AppColors.azulIntermedio,
          mostrarBack: true,
          contenidoPersonalizado: _buildProfileContent(context, user),
        );
      },
    );
  }

  Widget _buildProfileContent(BuildContext context, User user) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(user.nombre, style: AppTextStyles.subtitulo),
              ),
              if (user.rol != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user.rol!.toUpperCase(),
                    style: AppTextStyles.textoSecundario.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),

          // Título y botón editar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'INFORMACIÓN PERSONAL',
                style: AppTextStyles.textoSecundarioTitulos,
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  mostrarEditarUsuario(context, user, () {
                    showCustomSnackBar(context, 'Perfil editado correctamente');
                    _recargarUsuario(); // Aquí recargas los datos
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          _info(Icons.email, user.correo),
          _info(Icons.phone, user.telefono),
          _info(Icons.location_on, user.direccion),
          _info(Icons.badge, user.id.toString()),
          const SizedBox(height: 24),

          const Text('ESPECIALIDAD',
              style: AppTextStyles.textoSecundarioTitulos),
          const SizedBox(height: 16),
          user.especialidad != null
              ? _section(
                  Colors.grey[50]!,
                  '${user.especialidad!.id} - ${user.especialidad!.nombre}',
                  user.especialidad!.descripcion,
                )
              : const Text('Sin especialidad registrada',
                  style: AppTextStyles.textoSecundario),
          const SizedBox(height: 24),

          const Text('ACCESO', style: AppTextStyles.textoSecundarioTitulos),
          const SizedBox(height: 16),
          _section(Colors.red[50]!, '••••••••••', 'Contraseña protegida'),
          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(child: _card('ARL', user.arl ?? 'No asignado')),
              const SizedBox(width: 16),
              Expanded(
                  child: _card(
                      'SEGURO SOCIAL', user.suguroSocial ?? 'No asignado')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 12),
          Text(text, style: AppTextStyles.cuerpo),
        ]),
      );

  Widget _section(Color color, String title, String subtitle) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppTextStyles.textoSecundarioTitulos),
          const SizedBox(height: 4),
          Text(subtitle, style: AppTextStyles.textoSecundario),
        ]),
      );

  Widget _card(String label, String value, [String? badge]) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
        child: Column(children: [
          Text(label,
              style: AppTextStyles.textoSecundario.copyWith(fontSize: 12)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  AppTextStyles.cuerpo.copyWith(fontWeight: FontWeight.w600)),
        ]),
      );
}
