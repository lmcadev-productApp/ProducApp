import 'package:flutter/material.dart';

class OpcionItem {
  final IconData icono;
  final Color colorIcono;
  final String texto;
  final VoidCallback onTap;

  OpcionItem({
    required this.icono,
    required this.colorIcono,
    required this.texto,
    required this.onTap,
  });
}

class GeneralOptionsSheet extends StatelessWidget {
  final String titulo;
  final List<OpcionItem> opciones;

  const GeneralOptionsSheet({
    super.key,
    required this.titulo,
    required this.opciones,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...opciones.map(
            (opcion) => ListTile(
              leading: Icon(opcion.icono, color: opcion.colorIcono),
              title: Text(opcion.texto),
              onTap: () {
                Navigator.pop(context);
                opcion.onTap();
              },
            ),
          ),
        ],
      ),
    );
  }
}
