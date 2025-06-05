import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String texto;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool espacioInferior;

  const CustomButton({
    super.key,
    required this.texto,
    this.backgroundColor = const Color(0xFF4A90E2),
    this.foregroundColor = Colors.white,
    this.espacioInferior = false,
  });

  @override
  Widget build(BuildContext context) {
    final boton = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {}, // Botón activo pero sin lógica
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 2,
        ),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );

    return espacioInferior
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              boton,
              const SizedBox(height: 16),
            ],
          )
        : boton;
  }
}
