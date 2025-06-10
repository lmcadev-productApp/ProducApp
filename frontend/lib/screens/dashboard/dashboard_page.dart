import 'package:flutter/material.dart';
import 'package:frontend/screens/admin/analytics/analytics_page.dart';
import 'package:frontend/screens/admin/orders/orders_page.dart';
import 'package:frontend/screens/admin/stage/stages_page.dart';
import 'package:frontend/screens/admin/users/users_page.dart';
import 'package:frontend/screens/stages/stage_screen.dart';
import 'package:frontend/utils/shared_preferences_helper.dart';
import 'package:frontend/screens/login/login_page.dart';
import 'package:frontend/widgets/dashboard/dashboard_grid.dart';
import 'package:frontend/widgets/section/section_header.dart';

class Dashboard extends StatefulWidget {
  @override
  _EstadoDashboard createState() => _EstadoDashboard();
}

class _EstadoDashboard extends State<Dashboard> {
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

  void _navegarAUsuarios() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminUserStateManagement()),
    );
  }

  void _navegarAOrdenes() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminOrderStateManagement()),
    );
  }

  void _navegarAEtapas() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StagesScreen()),
    );
  }

  void _navegarAReportes() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminAnalytics()),
    );
  }

  void _navegarAAsinarcionUsuarios() {
    print('Navegando a la Asinación de Usuarios');
  }

  void _navegarAAyuda() {
    print('Navegando a Ayuda');
  }

  String capitalizar(String texto) {
    if (texto.isEmpty) return texto;
    return texto[0].toUpperCase() + texto.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final List<DashboardItem> todosLosElementos = [
      DashboardItem(
        icon: Icons.people,
        title: 'Usuarios',
        onTap: _navegarAUsuarios,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.assignment,
        title: 'Órdenes',
        onTap: _navegarAOrdenes,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.timeline,
        title: 'Etapas',
        onTap: _navegarAEtapas,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.assessment,
        title: 'Reportes',
        onTap: _navegarAReportes,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.settings,
        title: 'Asignación de Usuarios',
        onTap: _navegarAAsinarcionUsuarios,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.help,
        title: 'Ayuda',
        onTap: _navegarAAyuda,
        iconColor: const Color(0xFF4A90E2),
      ),
    ];

    // Filtrado de elementos según el rol
    List<DashboardItem> elementosFiltrados = [];

    switch (_rol.toUpperCase()) {
      case 'ADMINISTRADOR':
        elementosFiltrados = todosLosElementos;
        break;
      case 'SUPERVISOR':
        elementosFiltrados = todosLosElementos
            .where((item) => item.title != 'Usuarios' && item.title != 'Etapas')
            .toList();
        break;
      case 'OPERARIO':
        elementosFiltrados =
            todosLosElementos.where((item) => item.title == 'Ayuda').toList();
        break;
      default:
        elementosFiltrados = [];
        break;
    }

    return BaseScreen(
      titulo: 'Bienvenido ${capitalizar(_rol)}',
      mostrarLogout: true,
      mostrarBack: false,
      onLogout: () async {
        await SharedPreferencesHelper.clearToken();
        await SharedPreferencesHelper.clearRol();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      contenido: DashboardGrid(
        items: elementosFiltrados,
        backgroundColor: Colors.transparent,
        cardColor: const Color.fromARGB(255, 255, 255, 255),
        textColor: Colors.black87,
        iconSize: 48,
        fontSize: 16,
        spacing: 16,
        padding: const EdgeInsets.all(16),
      ),
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
