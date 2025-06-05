import 'package:flutter/material.dart';
import 'package:frontend/screens/admin/analytics/analytics_page.dart';
import 'package:frontend/screens/admin/orders/orders_page.dart';
import 'package:frontend/screens/admin/stage/stages_page.dart';
import 'package:frontend/screens/admin/users/users_page.dart';
import 'package:frontend/utils/shared_preferences_helper.dart';
import 'package:frontend/widgets/section/section_header.dart';
import 'package:frontend/screens/login/login_page.dart';
import 'package:frontend/widgets/dashboard/dashboard_grid.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // Funciones para navegar a diferentes pantallas
  void _navigateToUsers() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AdminUserStateManagement()));
    print('Navegando a Usuarios');
  }

  void _navigateToOrders() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminOrders()));
    print('Navegando a Órdenes');
  }

  void _navigateToStages() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminStages()));
    print('Navegando a Etapas');
  }

  void _navigateToReports() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminAnalytics()));
    print('Navegando a Reportes');
  }

  void _navigateToSettings() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
    print('Navegando a Configuración');
  }

  void _navigateToHelp() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => HelpScreen()));
    print('Navegando a Ayuda');
  }

  @override
  Widget build(BuildContext context) {
    // Lista de items del dashboard
    final List<DashboardItem> dashboardItems = [
      DashboardItem(
        icon: Icons.people,
        title: 'Usuarios',
        onTap: _navigateToUsers,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.assignment,
        title: 'Órdenes',
        onTap: _navigateToOrders,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.timeline,
        title: 'Etapas',
        onTap: _navigateToStages,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.assessment,
        title: 'Reportes',
        onTap: _navigateToReports,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.settings,
        title: 'Configuración',
        onTap: _navigateToSettings,
        iconColor: const Color(0xFF4A90E2),
      ),
      DashboardItem(
        icon: Icons.help,
        title: 'Ayuda',
        onTap: _navigateToHelp,
        iconColor: const Color(0xFF4A90E2),
      ),
    ];

    // Contenido de la pantalla usando el DashboardGrid
    Widget contenidoPantalla = DashboardGrid(
      items: dashboardItems,
      backgroundColor: const Color(0xFFF5F5F5),
      cardColor: Colors.white,
      textColor: Colors.black87,
      iconSize: 48,
      fontSize: 16,
      spacing: 16,
      padding: const EdgeInsets.all(16),
    );

    // Widget reutilizable
    return BaseScreen(
      titulo: 'DashBoard',
      mostrarLogout: true,
      mostrarBack: false,
      onLogout: () async {
        await SharedPreferencesHelper.clearToken(); // Elimina el token
        await SharedPreferencesHelper.clearRol(); // Elimina el rol
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      contenido: contenidoPantalla,
      colorHeader: const Color(0xFF4A90E2),
    );
  }
}
