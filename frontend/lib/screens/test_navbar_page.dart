import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_page.dart';
import 'package:frontend/utils/shared_preferences_helper.dart';
import 'package:frontend/widgets/section/section_header.dart';

class WidgetGenerico extends StatefulWidget {
  const WidgetGenerico({Key? key}) : super(key: key);

  @override
  _WidgetGenericoState createState() => _WidgetGenericoState();
}

class _WidgetGenericoState extends State<WidgetGenerico> {
  String _rol = '';

  @override
  void initState() {
    super.initState();
    _cargarRolDesdePreferencias();
  }

  Future<void> _cargarRolDesdePreferencias() async {
    String? rol = await SharedPreferencesHelper.getRol();
    setState(() {
      _rol = rol ?? 'USUARIO';
    });
  }

  String capitalizar(String texto) {
    if (texto.isEmpty) return texto;
    return texto[0].toUpperCase() + texto.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      titulo: 'ProducApp ${capitalizar(_rol)}',
      mostrarLogout: true,
      mostrarBack: false,
      onLogout: () async {
        await SharedPreferencesHelper.clearToken();
        await SharedPreferencesHelper.clearRol();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      contenido: Center(
        child: Text(
          '¡Hola, ProducApp!',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
