import 'package:flutter/material.dart';
import 'package:frontend/helper/shared_preferences_helper.dart';
import 'package:frontend/screens/admin/analytics/analytics_page.dart';
import 'package:frontend/screens/admin/orders/orders_page.dart';
import 'package:frontend/screens/admin/users/users_page.dart';
import 'package:frontend/screens/stages/stage_screen.dart';
import 'package:frontend/screens/login/login_page.dart';
import 'package:frontend/utils/AppColors.dart';
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

  void _navegarA(BuildContext context, Widget pagina) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => pagina));
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
        onTap: () => _navegarA(context, AdminUserStateManagement()),
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.assignment,
        title: 'Órdenes',
        onTap: () => _navegarA(context, AdminOrderStateManagement()),
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.timeline,
        title: 'Etapas',
        onTap: () => _navegarA(context, StagesScreen()),
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.assessment,
        title: 'Reportes',
        onTap: () => _navegarA(context, AdminAnalytics()),
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.settings,
        title: 'Asignación de Usuarios',
        onTap: () => debugPrint('Navegando a la Asignación de Usuarios'),
        iconColor: AppColors.azulLogoPrincipal,
      ),
      DashboardItem(
        icon: Icons.help_outline,
        title: 'Ayuda',
        onTap: () => debugPrint('Navegando a Ayuda'),
        iconColor: AppColors.azulLogoPrincipal,
      ),
    ];

    List<DashboardItem> elementosFiltrados;
    switch (_rol.toUpperCase()) {
      case 'ADMINISTRADOR':
        elementosFiltrados = todosLosElementos;
        break;
      case 'SUPERVISOR':
        elementosFiltrados = todosLosElementos.where((item) => item.title != 'Usuarios' && item.title != 'Etapas').toList();
        break;
      case 'OPERARIO':
        elementosFiltrados = todosLosElementos.where((item) => item.title == 'Ayuda').toList();
        break;
      default:
        elementosFiltrados = [];
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
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      },
      contenidoPersonalizado: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Qué deseas gestionar hoy?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.azulLogoPrincipal,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: DashboardGrid(
                items: elementosFiltrados,
                backgroundColor: Colors.white,
                cardColor: Colors.white,
                textColor: AppColors.azulIntermedio,
                iconSize: 52,
                fontSize: 16,
                spacing: 20,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, item) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.azulIntermedio,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.azulIntermedio,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: item.onTap,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, size: 52, color: item.iconColor),
                        const SizedBox(height: 12),
                        Text(
                          item.title,
                          style: const TextStyle(
                            color: AppColors.azulIntermedio,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      colorHeader: AppColors.azulIntermedio,
    );
  }
}
