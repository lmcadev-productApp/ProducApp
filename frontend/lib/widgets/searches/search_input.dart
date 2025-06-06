import 'package:flutter/material.dart';

/// Widget de campo de búsqueda reutilizable y funcional
/// Permite búsqueda en tiempo real con diseño consistente
class SearchInput extends StatelessWidget {
  // Propiedades básicas
  final String hintText; // Texto de ayuda que se muestra
  final bool espacioInferior; // Si agrega espacio abajo del campo

  // Propiedades funcionales (nuevas)
  final Function(String)? onChanged; // Se ejecuta cada vez que cambia el texto
  final Function(String)? onSubmitted; // Se ejecuta al presionar Enter
  final VoidCallback? onTap; // Se ejecuta al tocar el campo
  final TextEditingController? controller; // Controlador para manejar el texto
  final bool readOnly; // Si el campo es solo lectura
  final bool enabled; // Si el campo está habilitado

  /// Constructor simple del SearchInput
  const SearchInput({
    super.key,
    this.hintText = 'Buscar...', // Texto por defecto
    this.espacioInferior = false, // Sin espacio por defecto
    this.onChanged, // Opcional: función de cambio
    this.onSubmitted, // Opcional: función de envío
    this.onTap, // Opcional: función de toque
    this.controller, // Opcional: controlador externo
    this.readOnly = false, // Por defecto permite escritura
    this.enabled = true, // Por defecto está habilitado
  });

  @override
  Widget build(BuildContext context) {
    // El campo de búsqueda principal
    final searchField = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25), // Bordes redondeados
        border: Border.all(
          color: const Color.fromARGB(255, 109, 109, 109),
          width: 1,
        ),
        // Sombra sutil para darle profundidad
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller, // Usa el controlador si se proporciona
        readOnly: readOnly, // Controla si es solo lectura
        enabled: enabled, // Controla si está habilitado
        onChanged: onChanged, // Ejecuta función cuando cambia el texto
        onSubmitted: onSubmitted, // Ejecuta función al presionar Enter
        onTap: onTap, // Ejecuta función al tocar
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
          border: InputBorder.none, // Sin borde interno
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );

    // Retorna con o sin espacio inferior según se necesite
    return espacioInferior
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchField,
              const SizedBox(height: 16), // Espacio de 16px abajo
            ],
          )
        : searchField; // Solo el campo sin espacio extra
  }
}

/*
EJEMPLOS DE USO FÁCILES:

// 1. BÚSQUEDA BÁSICA (solo visual)
SearchInput(
  hintText: 'Buscar productos...',
),

// 2. BÚSQUEDA FUNCIONAL (detecta cambios)
SearchInput(
  hintText: 'Buscar usuarios...',
  onChanged: (texto) {
    print('Buscando: $texto');
    // Aquí filtras tu lista
  },
),

// 3. BÚSQUEDA CON CONTROLADOR
final TextEditingController _searchController = TextEditingController();

SearchInput(
  controller: _searchController,
  hintText: 'Buscar...',
  onChanged: (texto) {
    // Filtrar lista en tiempo real
    filtrarLista(texto);
  },
),

// 4. CAMPO SOLO PARA MOSTRAR (que abre otra pantalla)
SearchInput(
  hintText: 'Tocar para buscar...',
  readOnly: true,
  onTap: () {
    // Navegar a pantalla de búsqueda completa
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => PantallaBusqueda(),
    ));
  },
),

// 5. CON ESPACIO INFERIOR
SearchInput(
  hintText: 'Buscar...',
  espacioInferior: true,  // Agrega espacio abajo
  onChanged: (texto) => buscar(texto),
),

// 6. BÚSQUEDA DESHABILITADA
SearchInput(
  hintText: 'Búsqueda no disponible',
  enabled: false,  // Campo deshabilitado
),

EJEMPLO COMPLETO EN UNA PANTALLA:

class MiPantalla extends StatefulWidget {
  @override
  _MiPantallaState createState() => _MiPantallaState();
}

class _MiPantallaState extends State<MiPantalla> {
  List<String> productos = ['Manzana', 'Banana', 'Cereza'];
  List<String> productosFiltrados = [];

  @override
  void initState() {
    super.initState();
    productosFiltrados = productos;  // Mostrar todos al inicio
  }

  void filtrarProductos(String consulta) {
    setState(() {
      if (consulta.isEmpty) {
        productosFiltrados = productos;
      } else {
        productosFiltrados = productos.where((producto) =>
          producto.toLowerCase().contains(consulta.toLowerCase())
        ).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Campo de búsqueda funcional
          SearchInput(
            hintText: 'Buscar productos...',
            espacioInferior: true,
            onChanged: filtrarProductos,  // Filtra en tiempo real
          ),
          
          // Lista filtrada
          Expanded(
            child: ListView.builder(
              itemCount: productosFiltrados.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productosFiltrados[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/
