import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final String hintText;
  final bool espacioInferior;

  const SearchInput({
    super.key,
    this.hintText = 'Buscar...',
    this.espacioInferior = false,
  });

  @override
  Widget build(BuildContext context) {
    final input = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color.fromARGB(255, 109, 109, 109),
          width: 1,
        ),
      ),
      child: TextField(
        readOnly: true, // Solo para mostrar, sin permitir edición
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );

    return espacioInferior
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              input,
              const SizedBox(height: 16),
            ],
          )
        : input;
  }
}
