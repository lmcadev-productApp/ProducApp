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
import 'package:frontend/screens/admin/orders/orders_Phases_StateManagement.dart';

class orders_mainPage extends StatefulWidget {
  @override
  _orders_mainPage createState() => _orders_mainPage();
}

class _orders_mainPage extends State<orders_mainPage> {
  String _rol = '';

  @override
  void initState() {
    super.initState();
    _cargarRolDesdePreferencias();
  }

  Future<void> _cargarRolDesdePreferencias() async {
    String? rol = await SharedPreferencesHelper.getRol();
    setState(() {
      _rol = rol ?? 'ADMINISTRADOR'; // Valor por defecto si no se encuentra el rol
    });
  }

  void _navegarAAdministrarOrdenes() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminOrderStateManagement()),
    );
  }

  void _navegarAAsignarOrdenes() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminOrdersPhaseStateManagement()),
    );
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
        title: 'Administrar Ordenes',
        onTap: _navegarAAdministrarOrdenes,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.assignment,
        title: 'Asignar Ordenes a Usuarios',
        onTap: _navegarAAsignarOrdenes,
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
