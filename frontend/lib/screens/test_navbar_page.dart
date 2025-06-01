import 'package:flutter/material.dart';

class WidgetGenerico extends StatelessWidget {
  const WidgetGenerico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clase Genérica ProducApp')),
      body: Center(
        child: Text('¡Hola, ProducApp!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
