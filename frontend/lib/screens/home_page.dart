import 'package:flutter/material.dart';
import 'package:frontend/screens/test_navbar_page.dart';

class HomePage extends StatefulWidget {
  final String userRole;

  const HomePage({Key? key, required this.userRole}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;
  late final List<BottomNavigationBarItem> _navItems;

  @override
  void initState() {
    super.initState();

    switch (widget.userRole) {
      case 'admin':
        _pages = [
          WidgetGenerico(),
          WidgetGenerico(),
          WidgetGenerico(),
          WidgetGenerico(),
          WidgetGenerico(),
          //AdminDashboard(),
          //GestionRoles(),
          //UsuariosPage(),
          //EtapasPage(),
          //AnalisisProduccion(),
        ];
        _navItems = [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: 'Roles'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Usuarios'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Etapas'),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Análisis',
          ),
        ];
        break;

      case 'supervisor':
        _pages = [
          WidgetGenerico(),
          WidgetGenerico(),
          WidgetGenerico(),
          WidgetGenerico(),
          //SupervisorDashboard(),
          //AsignarEmpleados(),
          //OrdenesTrabajo(),
          //ReportesSupervisor(),
        ];
        _navItems = [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Asignar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Órdenes'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reportes',
          ),
        ];
        break;

      case 'operario':
        _pages = [
          WidgetGenerico(),
          WidgetGenerico(),
          WidgetGenerico(),
          WidgetGenerico(),
          //OperarioDashboard(),
          //OrdenesAsignadas(),
          //EjecucionEtapa(),
          //ReporteAvance(),
        ];
        _navItems = [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Órdenes',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Etapas'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reportes'),
        ];
        break;

      default:
        _pages = [Center(child: Text("Rol no reconocido"))];
        _navItems = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: _navItems,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
