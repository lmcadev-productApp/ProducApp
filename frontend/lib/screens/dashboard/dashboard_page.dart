import 'package:flutter/material.dart';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:frontend/screens/admin/analytics/analytics_page.dart';
import 'package:frontend/screens/admin/orders/orders_mainPage.dart';
import 'package:frontend/screens/admin/users/users_page.dart';
import 'package:frontend/screens/porfile/porfile_screen.dart';
import 'package:frontend/screens/specialties/specialtie_page.dart';
import 'package:frontend/screens/stages/stage_screen.dart';
import 'package:frontend/screens/login/login_page.dart';
import 'package:frontend/utils/AppColors.dart';
import 'package:frontend/widgets/dashboard/dashboard_grid.dart';
import 'package:frontend/widgets/section/section_header.dart';
import '../assingToUser/assingToUser.dart';
import 'package:frontend/screens/stageList/stageList.dart';

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
      MaterialPageRoute(builder: (context) => orders_mainPage()),
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

  void _navegarAAsignacionUsuarios() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AssingToUser()),
    );
  }

  void _navegarAEtapasAsignadas() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StageList()),
    );
  }

  void _navegarAEspecialidades() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpecialtyScreen()),
    );
  }

  void _navegarAlPerfil() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfileScreen()),
    );
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
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.assignment,
        title: 'Órdenes',
        onTap: _navegarAOrdenes,
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.timeline,
        title: 'Etapas',
        onTap: _navegarAEtapas,
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.engineering,
        title: 'Especialidades',
        onTap: _navegarAEspecialidades,
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.assessment,
        title: 'Reportes',
        onTap: _navegarAReportes,
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.settings,
        title: 'Asignación de Personal',
        onTap: _navegarAAsignacionUsuarios,
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.checklist,
        title: 'Etapas asignadas',
        onTap: _navegarAEtapasAsignadas,
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.account_circle,
        title: 'Perfil',
        onTap: _navegarAlPerfil,
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.help,
        title: 'Ayuda',
        onTap: _navegarAAyuda,
        iconColor: AppColors.azulLogoPrincipal,
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
        elementosFiltrados = todosLosElementos
            .where((item) => item.title == 'Ayuda' || item.title == 'Perfil')
            .toList();
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
      contenidoPersonalizado: DashboardGrid(
        items: elementosFiltrados,
        backgroundColor: Colors.transparent,
        cardColor: const Color.fromARGB(255, 255, 255, 255),
        textColor: Colors.black87,
        iconSize: 48,
        fontSize: 16,
        spacing: 16,
        padding: const EdgeInsets.all(16),
      ),
      colorHeader: AppColors.azulIntermedio,
    );
  }
}


